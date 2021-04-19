#!/bin/sh

apk add lighttpd php7 php-gettext php-session php7-phar php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom --no-cache

sed -i 's/#   include "mod_fastcgi.conf"/include "mod_fastcgi.conf"/g' /etc/lighttpd/lighttpd.conf
sed -i 's/# server.port          = 81/server.port = 5050/g' /etc/lighttpd/lighttpd.conf
sed -i 's/usr\/bin\/php-cgi/usr\/bin\/php-cgi7/g' /etc/lighttpd/mod_fastcgi.conf

mkdir -p /var/run/lighttpd
touch /var/run/lighttpd/php-fastcgi.socket
chown -R lighttpd:lighttpd /var/run/lighttpd

cd /tmp/
tar -xzf wordpress.tar.gz
mv wordpress/* /var/www/localhost/htdocs/
rm wordpress.tar.gz
rmdir wordpress
