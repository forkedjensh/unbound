FROM alpine

LABEL maintainer="Jens Heidbüchel <forkedjensh@mailbox.org>"

RUN apk add --no-cache curl unbound

RUN mkdir /var/lib/unbound
RUN curl --output /var/lib/unbound/root.hints https://www.internic.net/domain/named.cache
RUN unbound-anchor -4 -a /var/lib/unbound/root.key; true
RUN chown -R unbound:unbound /var/lib/unbound

ADD unbound.conf /etc/unbound/unbound.conf

EXPOSE 53/udp
EXPOSE 53/tcp

CMD [ "unbound", "-d" ]
