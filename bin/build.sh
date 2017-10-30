#!/usr/bin/env bash

set -e

# Check for GNU Parrallel.
echo "Checking for GNU Parallel..."
which parallel || \
  { echo "This script requires GNU Parallel - https://www.gnu.org/software/parallel/"; exit 1; }
echo "Okay."

function _build {
  DOCKERFILE=$(readlink -f $1) # Full path of Dockerfile.
  DIR="$(dirname $DOCKERFILE)" # Full path of Dockerfile parent.
  ID="$(basename $DIR)" # Name of Dockerfile parent directory.
  LOG_PATH="$(readlink -f ./log/$ID.log)"
  echo "Building: $DOCKERFILE"
  docker build -t $ID $DIR > $LOG_PATH 2>&1
  echo "Finished: $DOCKERFILE. View log at $LOG_PATH"
}

# Export build function for use with parallel.
export -f _build
find ./dist -type f -name 'Dockerfile' | parallel _build
