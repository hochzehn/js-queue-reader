#!/usr/bin/env bash

if [ $# -ne 1 ]
then
    echo "Usage: entrypoint.sh RESTMQ_URL"
else
    # Parameters
    DOWNLOAD_URL=$1

    TARGET_DIR=tmp
    TARGET_FILE=$(mktemp)

    shouldRun=true
    while [ "$shouldRun" = true ]; do

        # Load json from RestMQ
        result=$(curl -s "$DOWNLOAD_URL")

        #Extract value from json result
        detectedjs=$(echo "$result" | sed -e 's/^.*"value": "\(.*\)".*$/\1/')


        if [ -z "$detectedjs" ]; then
            shouldRun=false
        else
            echo $detectedjs >> "$TARGET_FILE"
        fi
    done

    cat "$TARGET_FILE"
fi
