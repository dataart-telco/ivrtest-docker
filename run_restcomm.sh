#!/bin/bash

source ./files/utils/read-network-props.sh "eth0"

docker rm -f restcomm

docker run --net host -d --name=restcomm \
    -e STATIC_ADDRESS=$PRIVATE_IP \
    -e INIT_PASSWORD=42d8aa7cde9c78c4757862d84620c335 \
    -e VOICERSS_KYE=29b2d893df9f454abbfae94df6cff95b \
    -e MEDIASERVER_LOWEST_PORT=64000 \
    -e MEDIASERVER_HIGHEST_PORT=65500 \
    -e PROD_MODE=true \
    hamsterksu/restcomm:7.6.0.824
