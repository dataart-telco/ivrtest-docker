FROM ivrtest
MAINTAINER = Gennadiy Dubina <gdubina@dataart.com>

ENV WORK_DIR /opt/ivrtest
ADD ./files/run_server.sh $WORK_DIR/run_server.sh

WORKDIR $WORK_DIR
CMD ./run_server.sh 
