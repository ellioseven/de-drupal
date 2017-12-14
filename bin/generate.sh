#!/usr/bin/env bash

set -e

# Distribution path.
DIST_DIR=./dist

# Container directory prefix.
PREFIX=/srv

# Generate mustache templates.
function _mustache () {
	 docker run \
		  --volume "$(pwd):$PREFIX" \
		  --workdir $PREFIX/templates \
		  -ti ellioseven/mustache /usr/bin/mustache $*
}

# Refresh distribution directory.
rm -rf $DIST_DIR
mkdir -p $DIST_DIR

# Loop artifact templates.
for ARTIFACT in $(find ./templates/ -type f -name '*.dockerfile.mustache'); do

	# Get artifact ID from file name, eg: './templates/example.dockerfile.mustache'
	# yields 'example'.
	ID=$(basename $ARTIFACT | awk -F '.' '{ print $1 }')
	mkdir -p $DIST_DIR/$ID

	# Generate mustache template. For some stange reason, mustache generates
	# Windows style line endings, remove them.
	# https://stackoverflow.com/questions/41100457/unable-to-solve-syntax-error-near-unexpected-token-fi-hidden-control-chara
	_mustache $PREFIX/etc/config.yml "$PREFIX/$ARTIFACT" | tr -d '\r' > $DIST_DIR/$ID/Dockerfile

	while read LINE; do
		# Extract file in an 'INCLUDE' declaraction.
		INCLUDE=$(echo $LINE | grep -E '^(INCLUDE)' | cut -d ' ' -f2)
			if [[ $INCLUDE ]]; then
				# Copy include to artifact.
				cp -R ./includes/$INCLUDE $DIST_DIR/$ID/
		  fi
	 done < $DIST_DIR/$ID/Dockerfile

	 # Remove all 'INCLUDE' declaractions.
	 sed -i /^INCLUDE/d $DIST_DIR/$ID/Dockerfile

done
