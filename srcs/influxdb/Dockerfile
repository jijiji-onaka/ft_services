FROM alpine:3.12

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
&& apk update \
&& apk add influxdb telegraf --no-cache

COPY srcs/init.sh /
RUN chmod +x init.sh

COPY ./srcs/telegraf.conf /etc/telegraf.conf

ENTRYPOINT ["/init.sh"]
