#!/bin/bash

echo "
***************
**
**   You can specify sipp params:
**
**   TEST_CALLS_RATE - calls rate
**   TEST_CALLS_MAX  - count of calls
**   TEST_CALLS_CONC - concurrent calls 
**
**************
"

mkdir -p log
rm log/ivrtest-server.log

docker rm -f ivrtest

source ./files/utils/read-network-props.sh "eth0"

docker run --rm \
    --net host \
    --name ivrtest \
    -e PORT=7090 \
    -e RESTCOMM_HOST="$PRIVATE_IP" \
    -e RESTCOMM_PORT=8080 \
    -e RESTCOMM_USER=ACae6e420f425248d6a26948c17a9e2acf \
    -e RESTCOMM_PSWD=42d8aa7cde9c78c4757862d84620c335 \
    -e PHONE_NUMBER=7777 \
    -v "$PWD/log":/opt/ivrtest/log \
    ivrtest

#    -e TEST_CALLS_RATE=5 \
#    -e TEST_CALLS_MAX=100 \
#    -e TEST_CALLS_CONC=20 \

