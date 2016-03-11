#!/bin/bash

source ./files/utils/read-network-props.sh "eth0"

docker run --name restcomm-mysql \
  --net host \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=restcomm \
  -e MYSQL_USER=restcomm \
  -e MYSQL_PASSWORD=secret \
  -d mysql

docker rm -f restcomm

#    --memory=12g \
#    --memory-swap=12g \
#    --memory-swappiness=0 \
#    --cpuset-cpus="0-3" \

docker run --net host -d --name=restcomm \
    -e STATIC_ADDRESS=$PRIVATE_IP \
    -e INIT_PASSWORD=42d8aa7cde9c78c4757862d84620c335 \
    -e VOICERSS_KYE=29b2d893df9f454abbfae94df6cff95b \
    -e MEDIASERVER_LOWEST_PORT=64000 \
    -e MEDIASERVER_HIGHEST_PORT=65500 \
    -e PROD_MODE=true \
    -e MYSQL_HOST=$PRIVATE_IP \
    -e MYSQL_SCHEMA=restcomm \
    -e MYSQL_USER=restcomm \
    -e MYSQL_PASSWORD=secret \
    hamsterksu/restcomm:7.5.0.800

