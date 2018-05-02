# curl -v -x socks5://telegram:fuckrkn1@172.17.0.2:1080 https://www.zinovyev.net

FROM ubuntu:18.04
ENV DANTE_VER 1.4.2
ENV DANTE_URL https://www.inet.no/dante/files/dante-$DANTE_VER.tar.gz
ENV DANTE_USERNAME username
ENV DANTE_PASSWORD password
ENV DANTE_PORT 1080
ENV DANTE_ADDRESS 0.0.0.0
RUN set -xe \
    && apt-get update \
    && apt-get install -y build-essential curl \
    && mkdir -p /tmp/dante \
        && cd /tmp/dante \
        && curl -sSL $DANTE_URL -o /tmp/dante/dante.tar.gz \
        && tar xzf ./dante.tar.gz --strip 1 \
        && ./configure \
        && make install \
        && rm -rf /tmp/dante \
    && apt-get purge -y --auto-remove build-essential curl \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -p $(openssl passwd -1 $DANTE_PASSWORD) $DANTE_USERNAME

ADD danted.conf /etc/sockd.conf
RUN sed -i s/1080/$DANTE_PORT/g /etc/sockd.conf
RUN sed -i s/0.0.0.0/$DANTE_ADDRESS/g /etc/sockd.conf

EXPOSE 108

CMD sockd
