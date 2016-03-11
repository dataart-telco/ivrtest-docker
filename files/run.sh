#!/bin/bash

service nginx restart 

mkdir -p $PWD/log

source ./utils/read-network-props.sh "eth0"

if [ -z "$TEST_CALLS_MAX" ]; then
    TEST_CALLS_MAX=5000
fi

if [ -z "$TEST_CALLS_CONC" ]; then
    TEST_CALLS_CONC=200
fi

if [ -z "$TEST_CALLS_RATE" ]; then
    TEST_CALLS_RATE=80
fi

echo "**********************"
echo "** Start ivr-test with params: "
echo "** TEST_CALLS_RATE: $TEST_CALLS_RATE"
echo "** TEST_CALLS_CONC: $TEST_CALLS_CONC"
echo "** TEST_CALLS_MAX: $TEST_CALLS_MAX"
echo "*********************"
echo ""

echo "Start ivr-server"

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

echo "Wait for ivr-server (3 sec)"
sleep 3

URL="http://$PRIVATE_IP:$PORT"
curl -s "$URL/start"

./test-ivr.sh $PRIVATE_IP "$RESTCOMM_HOST:5080" $PHONE_NUMBER

echo "Wait 7 sec before close"
sleep 7

echo "Server stat:"
curl -s "$URL/"

echo ""
echo "Dump to file: result.csv"

RESULT_INCOMING=`curl -s $URL/stat/incoming`
RESULT_RECEIVED=`curl -s $URL/stat/received`

echo "`date`,$TEST_CALLS_RATE,$TEST_CALLS_CONC,$TEST_CALLS_MAX,$RESULT_INCOMING,$RESULT_RECEIVED" >> /opt/ivrtest/result/result.csv
echo "--- TEST FINISHED ---"
