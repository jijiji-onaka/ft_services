#!/bin/sh

if ! pgrep nginx > /dev/null; then
	echo 'Process not found: nginx'
	exit 1
fi
if ! pgrep php-fpm7 > /dev/null; then
	echo 'Process not found: php-fpm7'
	exit 1
fi
