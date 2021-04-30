FROM alpine:3.12

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
&& apk update \
&& apk add vsftpd openssl telegraf --no-cache

RUN mkdir -p /etc/vsftpd/ssl \
&& openssl genrsa -out /etc/vsftpd/ssl/server.key 2048 \
&& openssl req -new -key /etc/vsftpd/ssl/server.key -out /etc/vsftpd/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=nginx-service" \
&& openssl x509 -days 3650 -req -signkey /etc/vsftpd/ssl/server.key -in /etc/vsftpd/ssl/server.csr -out /etc/vsftpd/ssl/server.crt

COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY srcs/init.sh /
RUN chmod +x /init.sh

COPY ./srcs/telegraf.conf /etc/telegraf.conf
RUN chmod +x /etc/telegraf.conf

COPY srcs/healthcheck.sh /
RUN chmod +x /healthcheck.sh

EXPOSE 21 21000-21005

ENTRYPOINT ["/init.sh"]