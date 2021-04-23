FROM alpine:3.12

RUN apk update \
&& apk add nginx wget openssl openssh mysql-client \
# php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7-mysqli php7-zlib php7 php7-phar \
php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session \
--no-cache

########### nginx ############

RUN mkdir -p /run/nginx
RUN mkdir /etc/nginx/ssl \
&& openssl genrsa -out /etc/nginx/ssl/server.key 2048 \
&& openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=nginx-service" \
&& openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt
COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/index.html /var/www/localhost/htdocs/index.html

##############################

########### wordpress ############

RUN cd /tmp \
&& wget http://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && rm latest.tar.gz \
&& mv wordpress /var/www/localhost/htdocs/wordpress \
&& chown -R nginx:nginx /var/www/localhost/htdocs/wordpress/
COPY ./srcs/wp-config.php /var/www/localhost/htdocs/wordpress/wp-config.php
RUN chown -R www:www ./wordpress/wp-config.php

#################################

########### php7-fpm ############

RUN mkdir -p /run/php
COPY srcs/php-fpm.conf /etc/php7/php-fpm.d/www.conf

#################################

COPY srcs/init.sh /

EXPOSE 5050

ENTRYPOINT ["/init.sh"]

#wordpressのインストール
#https://wiki.alpinelinux.org/wiki/WordPress
# RUN apk add lighttpd php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom
# RUN sed -i -e 's/#   include "mod_fastcgi.conf"/   include "mod_fastcgi.conf"/g' /etc/lighttpd/lighttpd.conf
# RUN sed -i -e 's/\/usr\/bin\/php-cgi/\/usr\/bin\/php-cgi7/g' /etc/lighttpd/mod_fastcgi.conf
# #RUN rc-service lighttpd start && rc-update add lighttpd default
# RUN rc-update add lighttpd default
# RUN rc-status
# RUN apk add php7-mysqli php7-zlib
# RUN /etc/init.d/lighttpd restart

#wordpressのファイル設置
# RUN mkdir -p /usr/share/webapps/
# RUN cd /usr/share/webapps/ && wget http://wordpress.org/latest.tar.gz && tar -xzvf latest.tar.gz && rm latest.tar.gz
# RUN chown -R lighttpd /usr/share/webapps/
# RUN ln -s /usr/share/webapps/wordpress/ /var/www/localhost/htdocs/wordpress
# RUN apk add php php7-phar curl
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
# wpコマンドはMySQLコンテナが動いていないと動かないので、一旦、CMDのmyapp.shのwp_init.shで実行
# RUN wp core install --url=http://127.0.0.1:5050/wordpress/ --title=test --admin_user=admin --admin_password=admin --admin_email=admin@example.com  --allow-root --path=/usr/share/webapps/wordpress/
# RUN wp language core activate ja --allow-root --path=/usr/share/webapps/wordpress/
# RUN wp user create bob bob@example.com --role=editor --user_pass=bob --allow-root --path=/usr/share/webapps/wordpress/
# RUN wp user create alice alice@example.com --role=author --user_pass=alice --allow-root --path=/usr/share/webapps/wordpress/
#RUN /etc/init.d/lighttpd restart

#telegrafのインストール
# RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
# RUN apk add telegraf@testing
# RUN rc-update add telegraf default
# RUN rc-status
# RUN telegraf -sample-config -input-filter cpu:mem -output-filter influxdb > telegraf.conf
# RUN sed -i -e 's/hostname = ""/hostname = "wordpress"/g' /etc/telegraf.conf
# RUN sed -i -e 's/# urls = \["http:\/\/127.0.0.1:8086"\]/urls = \["http:\/\/influxdb-service:8086"\]/g' /etc/telegraf.conf


#wordpress初期設定スクリプト設置と実行
# COPY ./srcs/wp_init.sh /wp_init.sh