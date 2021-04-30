FROM alpine:3.12

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
&& apk update \
&& apk add openssl libc6-compat telegraf --no-cache

########### grafana ############

RUN wget https://dl.grafana.com/oss/release/grafana-7.4.5.linux-amd64.tar.gz \
&& tar -xvf grafana-7.4.5.linux-amd64.tar.gz \
&& rm grafana-7.4.5.linux-amd64.tar.gz \
&& mv grafana-7.4.5 /etc/grafana \
&& mkdir -p /etc/grafana/ssl \
&& mkdir -p /var/lib/grafana/dashboards \
&& openssl genrsa -out /etc/grafana/ssl/server.key 2048 \
&& openssl req -new -key /etc/grafana/ssl/server.key -out /etc/grafana/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=nginx-service" \
&& openssl x509 -days 3650 -req -signkey /etc/grafana/ssl/server.key -in /etc/grafana/ssl/server.csr -out /etc/grafana/ssl/server.crt
COPY ./srcs/defaults.ini /etc/grafana/conf/defaults.ini
COPY ./srcs/datasources /etc/grafana/conf/provisioning/datasources
COPY ./srcs/dashboards /etc/grafana/conf/provisioning/dashboards

################################

COPY ./srcs/init.sh /
RUN chmod +x /init.sh

COPY ./srcs/telegraf.conf /etc/telegraf.conf
RUN chmod +x /etc/telegraf.conf

COPY srcs/healthcheck.sh /
RUN chmod +x /healthcheck.sh

EXPOSE 3000

ENTRYPOINT ["/init.sh"]