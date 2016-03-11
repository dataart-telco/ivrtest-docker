#!/bin/bash

echo "
***************
**
**   You can specify sipp params:
**
**   TEST_CALLS_RATE - calls rate
**   TEST_CALLS_CONC - concurrent calls 
**   TEST_CALLS_MAX  - count of calls
**
**************
"

mkdir -p log
mkdir -p result

rm log/ivrtest-server.log

docker rm -f ivrtest

if [ "$#" -eq 1 ]; then
  RESTCOMM_HOST=$1
else
  echo "Detecting private ip..."
  source ./files/utils/read-network-props.sh "eth0"
  RESTCOMM_HOST=$PRIVATE_IP
fi

echo "Restcomm host: $RESTCOMM_HOST"

docker run --rm \
    --net host \
    --name ivrtest \
    -e PORT=7090 \
    -e RESTCOMM_HOST=$RESTCOMM_HOST \
    -e RESTCOMM_PORT=8080 \
    -e RESTCOMM_USER=ACae6e420f425248d6a26948c17a9e2acf \
    -e RESTCOMM_PSWD=42d8aa7cde9c78c4757862d84620c335 \
    -e PHONE_NUMBER=7777 \
    -e TEST_CALLS_RATE=40 \
    -e TEST_CALLS_CONC=200 \
    -e TEST_CALLS_MAX=5000 \
    -v "$PWD/log":/opt/ivrtest/log \
    -v "$PWD/result":/opt/ivrtest/result \
    ivrtest

