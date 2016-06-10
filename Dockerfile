FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y redis-server git cmake curl python2.7 g++ \
      libboost-dev libboost-iostreams-dev libboost-serialization-dev libssl-dev

RUN locale-gen en_US.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_6.x | /bin/bash
RUN apt-get install -y nodejs
RUN curl -sL https://install.meteor.com | /bin/sh

RUN git clone --recursive --depth=1 https://github.com/algorithm-ninja/shuriken /shuriken

RUN npm config -g set python /usr/bin/python2.7
RUN cd /shuriken && make

RUN git clone --recursive --depth=1 https://github.com/algorithm-ninja/cotton /cotton
RUN cd /cotton/build && cmake .. && make

VOLUME /shurikenfs

WORKDIR /shuriken/shuriken-web
CMD meteor --settings <(echo '{"fileStoreRoot": "/shurikenfs"}')

WORKDIR /shurikenfs/files
