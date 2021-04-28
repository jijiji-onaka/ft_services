#!/bin/sh

php-fpm7

telegraf --config /etc/telegraf.conf &

nginx

sleep infinity