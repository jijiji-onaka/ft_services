FROM alpine:3.12

RUN apk update \
&& apk add nginx openssl openssh openrc supervisor --no-cache

# nginx #
RUN mkdir -p /run/nginx
## 証明書 ##
RUN mkdir /etc/nginx/ssl \
&& openssl genrsa -out /etc/nginx/ssl/server.key 2048 \
&& openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=nginx-service" \
&& openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt

COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/index.html /var/www/localhost/htdocs/index.html

# openrc #
RUN mkdir /run/openrc/
RUN touch /run/openrc/softlevel
RUN rc-update add nginx
# RUN rc-service nginx stop
# RUN rc-service nginx restart
# RUN rc-service nginx restart

# RUN rc-update add sshd
RUN rc-status

# supervisord #
COPY ./srcs/supervisord.conf /etc/

# COPY srcs/nginx.conf /etc/nginx/

EXPOSE 80 443

CMD /usr/bin/supervisord
