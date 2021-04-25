FROM alpine:3.12

RUN apk update \
&& apk add vsftpd openssl --no-cache
RUN apk --no-cache add vsftpd

RUN mkdir -p /etc/vsftpd/ssl \
&& openssl genrsa -out /etc/vsftpd/ssl/server.key 2048 \
&& openssl req -new -key /etc/vsftpd/ssl/server.key -out /etc/vsftpd/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=nginx-service" \
&& openssl x509 -days 3650 -req -signkey /etc/vsftpd/ssl/server.key -in /etc/vsftpd/ssl/server.csr -out /etc/vsftpd/ssl/server.crt

COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY srcs/init.sh /

EXPOSE 21 21000-21005

ENTRYPOINT ["/init.sh"]