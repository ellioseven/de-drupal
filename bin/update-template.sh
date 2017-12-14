#!/usr/bin/env bash

# Exit immediately if a simple command exits with a non-zero status.
set -e

# Treat unset variables as an error when performing parameter expansion.
set -u

REPOSITORY="git@github.com:ellioseven/docker-image-templating-system.git"
PROJECT_DIR="$(pwd)"

cd "$(mktemp -d)"
mkdir backup
git clone $REPOSITORY src --quiet
rsync \
  -rcvzh \
  --delete \
  --backup-dir="$(pwd)/backup" \
  --exclude="/.git" \
  --exclude="/dist" \
  --exclude="/etc" \
  --exclude="/includes" \
  --exclude="/templates" \
  --exclude="/README.md" \
  ./src/ $PROJECT_DIR/

# Overwrite version.
VERSION="$(git -C ./src describe --abbrev=0 --tags)"
echo $VERSION > $PROJECT_DIR/.version

