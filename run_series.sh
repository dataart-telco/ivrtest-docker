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

array=(
5,5,100
5,10,100
10,100,100
10,100,100
10,100,200
10,100,500
10,100,1000,
20,100,100
20,100,500
20,100,1000
20,100,5000,
40,100,1000,
40,100,5000,
20,200,500
20,200,1000
20,200,5000,
40,200,1000,
40,200,5000
)

for params in ${array[*]}
do
TEST_CALLS_RATE=`echo -n $params|cut -d , -f1`
TEST_CALLS_CONC=`echo -n $params|cut -d , -f2`
TEST_CALLS_MAX=`echo -n $params|cut -d , -f3`

docker run --rm \
    --net host \
    --name ivrtest \
    -e PORT=7090 \
    -e RESTCOMM_HOST=$RESTCOMM_HOST \
    -e RESTCOMM_PORT=8080 \
    -e RESTCOMM_USER=ACae6e420f425248d6a26948c17a9e2acf \
    -e RESTCOMM_PSWD=42d8aa7cde9c78c4757862d84620c335 \
    -e PHONE_NUMBER=7777 \
    -e TEST_CALLS_RATE=$TEST_CALLS_RATE \
    -e TEST_CALLS_MAX=$TEST_CALLS_MAX \
    -e TEST_CALLS_CONC=$TEST_CALLS_CONC \
    -v "$PWD/log":/opt/ivrtest/log \
    -v "$PWD/result":/opt/ivrtest/result \
    ivrtest
done
#    -e TEST_CALLS_RATE=5 \
#    -e TEST_CALLS_MAX=100 \
#    -e TEST_CALLS_CONC=20 \

