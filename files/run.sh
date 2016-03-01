#!/bin/bash

service nginx restart 

mkdir -p $PWD/log

source ./utils/read-network-props.sh "eth0"

./ivrtest-server \
    -h "$PRIVATE_IP" \
    -p "$PORT" \
    -n "$PHONE_NUMBER" \
    -r "$RESTCOMM_HOST:$RESTCOMM_PORT" \
    -r-user "$RESTCOMM_USER" \
    -r-pswd "$RESTCOMM_PSWD" \
    -res "$PRIVATE_IP:7080" \
    -res-msg "pcap/demo-prompt.wav" \
    -res-confirm "pcap/demo-prompt.wav" \
    -l TRACE \
    > $PWD/log/ivrtest-server.log \
    2>&1 &

sleep 3

URL="http://$PRIVATE_IP:$PORT"
curl "$URL/start"

./test-ivr.sh $PRIVATE_IP "$RESTCOMM_HOST:5080" $PHONE_NUMBER

sleep 5

echo "Server stat:"
curl "$URL/"

