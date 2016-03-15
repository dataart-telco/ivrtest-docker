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
5,10,1000
2,10,1000
5,10,5000)

array10=(
10,100,100
10,100,200
10,100,500
10,100,1000
10,100,5000
)

array10_50=(
10,50,1000
10,50,5000
)

array20_50=(
20,50,1000
20,50,5000
)

array40_50=(
40,50,1000
40,50,5000
)

array20=(
20,100,100
20,100,500
20,100,1000
20,100,5000
)

array40_100=(
40,100,1000
40,100,1000
)
array200=(
20,200,500
20,200,1000
20,200,5000
)

array40_200=(
40,200,1000
40,200,5000
)

array80_100_1000=(
80,100,1000
)

array80_100_5000=(
80,100,5000
)

array80_200_5000=(
80,200,5000
)

array15=(
15,100,1000
15,100,1000
15,200,1000
15,200,1000
)

for params in ${array15[*]}
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

