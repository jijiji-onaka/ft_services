FROM alpine:3.12

RUN apk update \
&& apk add nginx wget openssl openrc php7-fpm php7-mysqli php7-mbstring php7-json php7-session \
supervisor mysql mysql-client --no-cache

########### nginx ############

RUN mkdir -p /run/nginx
RUN mkdir /etc/nginx/ssl \
&& openssl genrsa -out /etc/nginx/ssl/server.key 2048 \
&& openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=Tokyo/L=/O=/OU=/CN=nginx-service" \
&& openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt
COPY ./srcs/default.conf /etc/nginx/conf.d/default.conf
COPY ./srcs/index.html /var/www/localhost/htdocs/index.html

##############################

# # openrc #
# RUN mkdir /run/openrc/
# RUN touch /run/openrc/softlevel
# RUN rc-update add nginx

# # php #
# RUN rc-update add php-fpm7
# RUN rc-status
# COPY ./srcs/index.php /var/www/localhost/htdocs/index.php
# RUN rc-service php-fpm7 start

########### phpmyadmin ############

RUN cd /tmp \
&& wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz \
&& tar xvf phpMyAdmin-5.0.2-all-languages.tar.gz \
&& mv phpMyAdmin-5.0.2-all-languages /var/www/localhost/htdocs/phpmyadmin \
&& chown -R nginx:nginx /var/www/localhost/htdocs/phpmyadmin/

###################################

########### php7-fpm ############

RUN mkdir -p /run/php
COPY srcs/php-fpm.conf /etc/php7/php-fpm.d/www.conf

#################################


#phpmyadminのインストール
# RUN cd /tmp \
# && wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz \
# && tar xvf phpMyAdmin-5.0.2-all-languages.tar.gz \
# && mv phpMyAdmin-5.0.2-all-languages /var/www/localhost/htdocs/phpmyadmin

# RUN mv /var/www/localhost/htdocs/phpmyadmin/config.sample.inc.php /var/www/localhost/htdocs/phpmyadmin/config.inc.php
# RUN sed -i -e 's/localhost/mysql_test/g' /var/www/localhost/htdocs/phpmyadmin/config.inc.php

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

#テストコマンド
#docker build -t phpmyadmin:000 .
#docker run -it --name phpmyadmin_test -p 5000:80 --network wordpress-network phpmyadmin:000 /bin/sh
#docker run -d  --name phpmyadmin_test -p 5000:80 --network wordpress-network phpmyadmin:000
#docker ps
#docker exec -it phpmyadmin_test sh
#docker container stop phpmyadmin_test
#docker container rm phpmyadmin_test

#後処理
#docker container prune

#mysql -u root
#$ SELECT User, Host FROM mysql.user;
#mysql -h 127.0.0.1 -P 33060 -u mysql -pmysql
#mysql -h 127.0.0.1 -P 3306 -u mysql -pmysql

#wget -S --no-check-certificate http://127.0.0.1/ -O -
#wget -S --no-check-certificate http://127.0.0.1/index.php -O -
#wget -S --no-check-certificate http://127.0.0.1/phpmyadmin/ -O -
#wget -S --no-check-certificate http://127.0.0.1:5000/index.html -O -
#wget -S --no-check-certificate http://127.0.0.1:5000/index.php -O -
#wget -S --no-check-certificate http://127.0.0.1:5000/phpmyadmin/ -O -

#ブラウザによる動作確認
#http://127.0.0.1:5000/
#http://127.0.0.1:5000/phpmyadmin/server_databases.php?server=1

#<none>のイメージを削除
#docker rmi $(docker images -f "dangling=true" -q)

#待受ポート確認
#netstat -lpn