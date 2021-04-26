FROM alpine:3.12

RUN apk update \
&& apk add openssl --no-cache

# RUN wget https://dl.grafana.com/oss/release/grafana-7.4.5.linux-amd64.tar.gz \
# && tar -xvf grafana-7.4.5.linux-amd64.tar.gz \
# && rm grafana-7.4.5.linux-amd64.tar.gz \
# && mv grafana-7.4.5 /usr/share/grafana

COPY srcs/init.sh /

EXPOSE 3000

ENTRYPOINT ["/init.sh"]