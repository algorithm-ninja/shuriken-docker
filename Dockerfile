FROM node:6

RUN apt-get update
RUN apt-get install -y redis-server locales git

RUN curl https://install.meteor.com | /bin/sh

RUN git clone --recursive --depth=1 https://github.com/algorithm-ninja/shuriken /shuriken
RUN cd /shuriken && make

RUN locale-gen en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

RUN git clone --recursive --depth=1 https://github.com/algorithm-ninja/cotton /cotton
RUN cd /cotton && make

VOLUME /shurikenfs

WORKDIR /shuriken/shuriken-web
CMD meteor --settings <(echo '{"fileStoreRoot": "/shurikenfs"}')

WORKDIR /shurikenfs/files
