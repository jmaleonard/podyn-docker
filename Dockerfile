FROM ubuntu:17.10
LABEL MAINTAINER 'Jared Leonard <jmaleonard@github.com>'
RUN apt-get update -y
RUN apt-get install -y  software-properties-common python-software-properties
RUN  add-apt-repository ppa:openjdk-r/ppa
RUN apt-get install -y git maven openjdk-8-jdk
RUN git clone https://github.com/GetWala/podyn
RUN cd podyn && mvn package
EXPOSE 80 443 3306 5432
COPY files/startscript.sh /root/startscript.sh
RUN chmod +x /root/startscript.sh 
ENTRYPOINT ["bash", "/root/startscript.sh"]
