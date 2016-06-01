#!/bin/sh

if [ $# -ne 1 ]
then
    echo "Usage: bin/run.sh RESTMQ_URL"
else

    NAME="hochzehn/$(basename ${PWD})"

    docker build --tag $NAME . > /dev/null

    docker run \
      --rm \
      $NAME \
      $*
fi
