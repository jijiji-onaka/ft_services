#!/bin/sh

cat > /etc/phpmyadmin/config.secret.inc.php <<EOF
<?php
\$cfg['blowfish_secret'] = '$(cat /dev/urandom | tr -dc '12345678abcdefghijkmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ,.+\-!' | fold -w 32 | grep -E '[12345678]' | grep -E '[,\.+\-\!]' | head -n 1)';
EOF

rm /var/www/localhost/htdocs/phpmyadmin/config.sample.inc.php

php-fpm7
nginx

sleep infinity