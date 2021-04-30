FROM alpine:3.12

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
&& apk update \
&& apk add nginx wget openssl php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session \
    mysql mysql-client telegraf --no-cache

########### nginx ############

RUN mkdir -p /run/nginx
RUN mkdir /etc/nginx/ssl \
&& openssl genrsa -out /etc/nginx/ssl/server.key 2048 \
&& openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=nginx-service" \
&& openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt
COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/index.html /var/www/localhost/htdocs/index.html

##############################

########### phpmyadmin ############

RUN cd /tmp && mkdir /etc/phpmyadmin \
&& wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz \
&& tar xvf phpMyAdmin-5.0.2-all-languages.tar.gz \
&& mv phpMyAdmin-5.0.2-all-languages /var/www/localhost/htdocs/phpmyadmin \
&& chown -R nginx:nginx /var/www/localhost/htdocs/phpmyadmin/ /etc/phpmyadmin \
&& sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /var/www/localhost/htdocs/phpmyadmin/libraries/vendor_config.php
COPY srcs/config.inc.php /etc/phpmyadmin/config.inc.php
# COPY srcs/config.inc.php /var/www/localhost/htdocs/phpmyadmin/config.inc.php

###################################

########### php7-fpm ############

RUN mkdir -p /run/php
COPY srcs/php-fpm.conf /etc/php7/php-fpm.d/www.conf

#################################

COPY srcs/init.sh /
RUN chmod +x /init.sh

COPY ./srcs/telegraf.conf /etc/telegraf.conf
RUN chmod +x /etc/telegraf.conf

COPY srcs/healthcheck.sh /
RUN chmod +x /healthcheck.sh

EXPOSE 5000

ENTRYPOINT ["/init.sh"]
