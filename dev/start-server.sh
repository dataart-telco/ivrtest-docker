#!/bin/bash

docker rm -f ivr-server

source ./files/utils/read-network-props.sh "eth0"

docker run --rm \
    --memory-swappiness=0 \
    --cpuset-cpus="0-3" \
    --net host \
    --name ivr-server \
    -e PORT=7090 \
    -e RESTCOMM_HOST="$PRIVATE_IP" \
    -e RESTCOMM_PORT=8080 \
    -e RESTCOMM_USER=ACae6e420f425248d6a26948c17a9e2acf \
    -e RESTCOMM_PSWD=42d8aa7cde9c78c4757862d84620c335 \
    -e PHONE_NUMBER=7777 \
    -e TEST_CALLS_RATE=10 \
    -e TEST_CALLS_MAX=500 \
    -e TEST_CALLS_CONC=50 \
   ivr-server
