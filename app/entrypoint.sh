#!/usr/bin/env bash

# Defaults
RESTMQ_IP_DEFAULT=127.0.0.1

# Parameters
restmq_ip=$1
if [ -z $restmq_ip ]; then
    echo "IP of restMQ not specified with argument \$1. Using default: $RESTMQ_IP_DEFAULT"
    restmq_ip=$RESTMQ_IP_DEFAULT
fi

DOWNLOAD_URL="http://$restmq:8888/q/detectedjs"
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
