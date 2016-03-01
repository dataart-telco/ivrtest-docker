#!/bin/bash

LOCAL_ADDRESS=$1
RESTCOMM_ADDRESS=$2
PHONE_NUMBER=$3

ulimit -n 500000

CALLS_MAX="$TEST_CALLS_MAX"
CALLS_CONC="$TEST_CALLS_CONC"
CALLS_RATE="$TEST_CALLS_RATE"

if [ -z "$CALLS_MAX" ]; then
    CALLS_MAX=5000
fi

if [ -z "$CALLS_CONC" ]; then
    CALLS_CONC=200
fi

if [ -z "$CALLS_RATE" ]; then
    CALLS_RATE=80
fi


sipp -sf ./tests/ivr/ivr-sipp.xml -s $PHONE_NUMBER $RESTCOMM_ADDRESS \
    -mi $LOCAL_ADDRESS:5090 \
    -l $CALLS_CONC \
    -m $CALLS_MAX \
    -r $CALLS_RATE \
    -trace_screen -trace_err \
    -recv_timeout 5000 -t un -nr
