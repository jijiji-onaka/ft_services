FROM alpine:3.12

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
&& apk update \
&& apk add nginx wget curl openssl openssh mysql-client \
    php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session php7-phar \
    telegraf --no-cache

########### nginx ############

RUN mkdir -p /run/nginx
RUN mkdir /etc/nginx/ssl \
&& openssl genrsa -out /etc/nginx/ssl/server.key 2048 \
&& openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=nginx-service" \
&& openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt
COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/index.html /var/www/localhost/htdocs/index.html

##############################

# ########### wordpress ############

# 5.7

RUN cd /tmp \
&& wget http://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && rm latest.tar.gz \
&& mv wordpress /var/www/localhost/htdocs/wordpress \
&& chown -R nginx:nginx /var/www/localhost/htdocs/wordpress/
COPY ./srcs/wp-config.php /var/www/localhost/htdocs/wordpress/wp-config.php
RUN chown -R nginx:nginx  /var/www/localhost/htdocs/wordpress/wp-config.php

# #################################

########### php7-fpm ############

RUN mkdir -p /run/php
COPY srcs/php-fpm.conf /etc/php7/php-fpm.d/www.conf

#################################

########### wp-cli ##############

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar \
&& mv wp-cli.phar /usr/local/bin/wp \
&& wp --info

#################################

COPY srcs/init.sh /
RUN chmod +x /init.sh

COPY ./srcs/telegraf.conf /etc/telegraf.conf
RUN chmod +x /etc/telegraf.conf

COPY srcs/healthcheck.sh /
RUN chmod +x /healthcheck.sh

EXPOSE 5050

ENTRYPOINT ["/init.sh"]
