#!/bin/bash

LOCAL_ADDRESS=$1
RESTCOMM_ADDRESS=$2
PHONE_NUMBER=$3

ulimit -n 500000

sipp -sf ./tests/ivr/ivr-sipp.xml -s $PHONE_NUMBER $RESTCOMM_ADDRESS -mi $LOCAL_ADDRESS:5090 -l 200 -m 5000 -r 80 -trace_screen -trace_err -recv_timeout 5000 -t un -nr
