FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get install -y build-essential libevent-dev
RUN apt-get install -y git subversion
RUN apt-get upgrade -y

RUN set -ex && adduser --disabled-password --gecos '' mux

ENV wrk /tmp

WORKDIR ${wrk}

RUN su -c 'git clone https://github.com/KrugerHeavyIndustries/btmux.git' mux

WORKDIR ${wrk}/btmux

RUN ./configure
RUN make install

RUN cp -a game.run/lib/* /usr/local/lib
RUN cp -a game.run/bin/* /usr/local/bin

RUN chgrp mux /usr/local/bin/*
RUN chown -R mux:mux game.run

RUN mkdir -p /var/mux
RUN chown mux.mux /var/mux

RUN su -c 'mv game.run /var/mux/game.factory_default' mux

RUN sed -i -E 's/BIN\=\.\/bin$/BIN\=\/usr\/local\/bin/g' /var/mux/game.factory_default/mux.config
RUN sed -i -E 's/TEXT\=\.\/text$/TEXT\=\/var\/mux\/game\/text/g' /var/mux/game.factory_default/mux.config
RUN sed -i -E 's/DATA\=\.\/data$/DATA\=\/var\/mux\/game\/data/g' /var/mux/game.factory_default/mux.config

COPY entrypoint.sh /usr/local/bin

ENV LD_LIBRARY_PATH=/usr/local/lib

EXPOSE 5555

WORKDIR /var/mux/game

ENTRYPOINT ["entrypoint.sh"]
