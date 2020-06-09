FROM ubuntu:20.04

RUN apt-get update -y
RUN apt-get install -y build-essential libevent-dev curl
RUN apt-get upgrade -y

RUN set -ex && adduser --disabled-password --gecos '' mux

ENV WRK /tmp

WORKDIR ${WRK}

ARG VERTAG="0.7.2"

RUN su -c 'curl -L https://github.com/KrugerHeavyIndustries/btmux/archive/${VERTAG}.tar.gz | tar xz' mux

WORKDIR ${WRK}/btmux-${VERTAG}

RUN ./configure
RUN make install

RUN sed -i -E 's/BIN\=\.\/bin$/BIN\=\/usr\/local\/bin/g' ${WRK}/btmux-${VERTAG}/game.run/mux.config
RUN sed -i -E 's/TEXT\=\.\/text$/TEXT\=\/var\/mux\/game\/text/g' ${WRK}/btmux-${VERTAG}/game.run/mux.config
RUN sed -i -E 's/DATA\=\.\/data$/DATA\=\/var\/mux\/game\/data/g' ${WRK}/btmux-${VERTAG}/game.run/mux.config

RUN mv game.run/lib/* /usr/local/lib
RUN mv game.run/bin/* /usr/local/bin

RUN chgrp mux /usr/local/bin/*
RUN chown -R mux:mux game.run

RUN mkdir -p /var/mux
RUN chown mux.mux /var/mux

RUN mkdir -p /usr/local/share/btmux
RUN chgrp mux /usr/local/share/btmux
RUN mv game.run /usr/local/share/btmux/game.factory_issue
RUN chgrp -R mux /usr/local/share/btmux/game.factory_issue

COPY entrypoint.sh /usr/local/bin

ENV LD_LIBRARY_PATH=/usr/local/lib

EXPOSE 5555

WORKDIR /var/mux/game

ENTRYPOINT ["entrypoint.sh"]
