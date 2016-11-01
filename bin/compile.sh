#!/usr/bin/env bash

set -e

ROOT=$(pwd)
source ./etc/core.conf

rm -rf $ROOT/$DIR_DIST
mkdir -p $ROOT/$DIR_DIST

for DOCKERFILE in $(ls $ROOT/$DIR_CONF/$DIR_CONF_DOCKERFILE/*);
do
  source $DOCKERFILE
  mkdir -p $ROOT/$DIR_DIST/$ID
  cd $ROOT/$DIR_DIST/$ID
  touch Dockerfile
  for PART in ${PARTS[@]};
  do
    cat $ROOT/$DIR_SRC/$DIR_SRC_PART/$PART/Dockerfile >> Dockerfile
    echo >> Dockerfile
    for LIB in $(find $ROOT/$DIR_SRC/$DIR_SRC_PART/$PART/* | grep -v Dockerfile);
    do
      cp -Lr $LIB .
    done
  done
done
