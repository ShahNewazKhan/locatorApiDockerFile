FROM ubuntu:14.04

MAINTAINER info@shahnewazkhan.ca

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10

RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

RUN apt-get update

RUN apt-get install -y mongodb-org

RUN apt-get install -y nodejs

RUN apt-get install -y npm

RUN apt-get install -y supervisor

RUN mkdir -p /data/db

RUN mkdir -p /var/log/supervisor

COPY . /locatorAPI

RUN cd /locatorAPI; npm install

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 27017 28017 3000

CMD ["service mongod stop && /usr/bin/supervisord"]