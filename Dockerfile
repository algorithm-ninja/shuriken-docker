FROM node:6

RUN apt-get update
RUN apt-get install -y redis-server locales git

RUN curl https://install.meteor.com | /bin/sh

RUN git clone --depth=1 https://github.com/algorithm-ninja/shuriken /shuriken

RUN cd /shuriken && make

RUN bash
