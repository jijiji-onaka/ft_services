FROM alpine:3.12

ENV PMA_VERSION=5.0.4

ENV TELEGRAF_VERSION=1.17.0 \
    TELEGRAF_HOSTNAME=phpmyadmin

RUN mkdir -p /run/nginx && \
    mkdir -p /run/php && \
    mkdir -p /var/www/html && \
    apk add --no-cache curl nginx php7-fpm php7-json php7-mysqli php7-mbstring php7-session openssl && \
    # Install phpMyAdmin
    curl -Lk -o phpMyAdmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz && \
    tar -xvzf phpMyAdmin.tar.gz -C /var/www/html --strip-components=1 && \
    rm phpMyAdmin.tar.gz && \
    sed -i "s@define('CONFIG_DIR'.*@define('CONFIG_DIR', '/etc/phpmyadmin/');@" /var/www/html/libraries/vendor_config.php

COPY srcs/nginx.conf /etc/nginx/conf.d/default.conf
COPY srcs/php-fpm.conf /etc/php7/php-fpm.d/www.conf
COPY srcs/config.inc.php /etc/phpmyadmin/config.inc.php
COPY srcs/start.sh /
COPY srcs/healthcheck.sh /

RUN chown -R nginx:nginx /var/www/html /etc/phpmyadmin && \
    chmod +x /start.sh && \
    chmod +x /healthcheck.sh

EXPOSE 80 443

CMD [ "/start.sh" ]
