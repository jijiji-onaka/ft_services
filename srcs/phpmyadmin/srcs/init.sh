#!/bin/sh

sed	-e "s/localhost/mysql/g" \
	/var/www/localhost/htdocs/phpmyadmin/config.sample.inc.php \
	> /var/www/localhost/htdocs/phpmyadmin/config.inc.php

cat > /etc/phpmyadmin/config.secret.inc.php <<EOF
<?php
\$cfg['blowfish_secret'] = '$(cat /dev/urandom | tr -dc '12345678abcdefghijkmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ,.+\-!' | fold -w 32 | grep -E '[12345678]' | grep -E '[,\.+\-\!]' | head -n 1)';
EOF

php-fpm7
nginx

sleep infinity