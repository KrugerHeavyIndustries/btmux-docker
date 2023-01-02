ARG VERTAG="0.7.5"
ARG WRK="/tmp"

FROM alpine:3.17.0 as build

ARG VERTAG
ARG WRK

RUN apk update && apk add build-base wget libevent-dev bash

RUN set -ex && adduser --disabled-password --gecos '' mux

WORKDIR ${WRK}

RUN su -c 'wget -q -O - https://github.com/KrugerHeavyIndustries/btmux/archive/refs/tags/${VERTAG}.tar.gz | tar x -vz' mux

WORKDIR ${WRK}/btmux-${VERTAG}

RUN ./configure
RUN make install

RUN sed -i -E 's/BIN\=\.\/bin$/BIN\=\/usr\/local\/bin/g' ${WRK}/btmux-${VERTAG}/game.run/mux.config
RUN sed -i -E 's/TEXT\=\.\/text$/TEXT\=\/var\/mux\/game\/text/g' ${WRK}/btmux-${VERTAG}/game.run/mux.config
RUN sed -i -E 's/DATA\=\.\/data$/DATA\=\/var\/mux\/game\/data/g' ${WRK}/btmux-${VERTAG}/game.run/mux.config

FROM alpine:3.17.0 as runtime

RUN apk update && apk add libstdc++ libevent bash

ARG VERTAG
ARG WRK

RUN set -ex && adduser --disabled-password --gecos '' mux

COPY --from=build ${WRK}/btmux-${VERTAG}/game.run/lib/* /usr/local/lib
COPY --from=build ${WRK}/btmux-${VERTAG}/game.run/bin/* /usr/local/bin

RUN chgrp mux /usr/local/bin/*

RUN mkdir -p /var/mux
RUN chown mux.mux /var/mux

RUN mkdir -p /usr/local/share/btmux
RUN chgrp mux /usr/local/share/btmux

COPY --from=build ${WRK}/btmux-${VERTAG}/game.run /usr/local/share/btmux/game.factory_issue
RUN chown -R mux:mux /usr/local/share/btmux/game.factory_issue

COPY entrypoint.sh /usr/local/bin

ENV LD_LIBRARY_PATH=/usr/local/lib

WORKDIR /var/mux/game

ENTRYPOINT ["entrypoint.sh"]
