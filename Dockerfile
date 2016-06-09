FROM node:6

RUN apt-get update
RUN apt-get install -y redis-server locales git

RUN curl https://install.meteor.com | /bin/sh

RUN git clone --depth=0 https://github.com/algorithm-ninja/shuriken /shuriken

RUN cd /shuriken/shuriken && make
RUN cd /shuriken/shuriken-web && make

RUN bash
