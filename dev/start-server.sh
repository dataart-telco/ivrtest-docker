#!/bin/bash

docker rm -f ivr-server

if [ "$#" -eq 1 ]; then
  RESTCOMM_HOST=$1
else
  echo "Detecting private ip..."
  source ./files/utils/read-network-props.sh "eth0"
  RESTCOMM_HOST=$PRIVATE_IP
fi

docker run --rm \
    --net host \
    --name ivr-server \
    -e PORT=7090 \
    -e RESTCOMM_HOST="$RESTCOMM_HOST" \
    -e RESTCOMM_PORT=8080 \
    -e RESTCOMM_USER=ACae6e420f425248d6a26948c17a9e2acf \
    -e RESTCOMM_PSWD=42d8aa7cde9c78c4757862d84620c335 \
    -e PHONE_NUMBER=7777 \
   -it ivr-server bash
