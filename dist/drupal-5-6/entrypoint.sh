#!/usr/bin/env bash

set -e

# Merge default global composer packages.
function _merge () {
  rsync -avzh /home/app/.composer.tmp/ /home/app/.composer
  touch /home/app/.composer/.lock
  chown -R app:app /home/app/.composer
}

# Check global composer lock.
if [ ! -f /home/app/.composer/.lock ]; then
  _merge
fi

# Remove temporary .composer.
rm -rf /home/app/.composer.tmp

# First arg is `-f` or `--some-option`.
if [ "${1#-}" != "$1" ]; then
	set -- php "$@"
fi

exec "$@"
