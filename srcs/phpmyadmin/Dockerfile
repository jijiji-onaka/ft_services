FROM alpine:3.12

RUN apk update \
&& apk add nginx wget openssl php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session \
mysql mysql-client --no-cache

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

RUN cd /tmp \
&& wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz \
&& tar xvf phpMyAdmin-5.0.2-all-languages.tar.gz \
&& mv phpMyAdmin-5.0.2-all-languages /var/www/localhost/htdocs/phpmyadmin \
&& chown -R nginx:nginx /var/www/localhost/htdocs/phpmyadmin/
COPY srcs/config.inc.php /etc/phpmyadmin/config.inc.php

###################################

########### php7-fpm ############

RUN mkdir -p /run/php
COPY srcs/php-fpm.conf /etc/php7/php-fpm.d/www.conf

#################################

#telegrafのインストール
# RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories
# RUN apk add telegraf
# RUN rc-update add telegraf default
# RUN rc-status
# RUN telegraf -sample-config -input-filter cpu:mem -output-filter influxdb > telegraf.conf
# RUN sed -i -e 's/hostname = ""/hostname = "phpmyadmin"/g' /etc/telegraf.conf
# RUN sed -i -e 's/# urls = \["http:\/\/127.0.0.1:8086"\]/urls = \["http:\/\/influxdb_test:8086"\]/g' /etc/telegraf.conf

COPY srcs/init.sh /

EXPOSE 5000

ENTRYPOINT ["/init.sh"]
