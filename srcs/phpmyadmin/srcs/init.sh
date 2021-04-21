#!/bin/sh

# sed -i \
# 	-e s/';listen.owner = nobody'/'listen.owner = nginx'/g \
# 	-e s/';listen.group = nobody'/'listen.group = nginx'/g \
# 	-e s/'user = nobody'/'user = nginx'/g \
# 	-e s/'group = nobody'/'group = nginx'/g \
# 	/etc/php7/php-fpm.d/www.conf

/usr/sbin/php-fpm7
/usr/sbin/nginx

sleep infinity