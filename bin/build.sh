#!/usr/bin/env bash

# Parallel needs to ensure bash is being used.
# http://stackoverflow.com/questions/23814360/gnu-parallel-and-bash-functions-how-to-run-the-simple-example-from-the-manual
export SHELL=$(type -p bash)

set -e

source ./etc/core.conf

export DIR_LOG $DIR_LOG

function docker_build () {
    ID=$(basename $1)
    docker rmi -f ${ID}
    docker build $1 -t ${ID} &> ./${DIR_LOG}/build-${ID}.txt
}

export -f docker_build

# Ensure parallel is installed.
which /usr/bin/parallel > /dev/null

mkdir -p ./${DIR_LOG}
find ./dist -name Dockerfile -exec dirname {} \; | /usr/bin/time parallel -a - docker_build
