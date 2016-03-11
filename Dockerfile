FROM hamsterksu/sipp:latest
MAINTAINER = Gennadiy Dubina <gdubina@dataart.com>

RUN sudo apt-get update
RUN sudo apt-get install -y nginx
RUN sudo apt-get install -y curl
RUN sudo apt-get install -y ipcalc
RUN sudo apt-get install -y vim

#config nginx

ADD conf/ivr-nginx /etc/nginx/sites-available/ivr
RUN ln -s /etc/nginx/sites-available/ivr /etc/nginx/sites-enabled/ivr
RUN rm /etc/nginx/sites-available/default

#test app
ENV WORK_DIR /opt/ivrtest
RUN mkdir $WORK_DIR

ADD ./files $WORK_DIR

WORKDIR $WORK_DIR
CMD ./run.sh 
