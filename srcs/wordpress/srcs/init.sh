#!/bin/sh

# WordPressセットアップ admin_user,admin_passwordは管理画面のログインID,PW
wp core install \
--url=https://192.168.49.50:5050 \
--title=ft_services \
--admin_user=admin \
--admin_password=admin \
--admin_email=admin@a.com

# 日本語化
wp language core install ja --activate --allow-root

# タイムゾーンと日時表記
wp option update timezone_string 'Asia/Tokyo' --allow-root
wp option update date_format 'Y-m-d' --allow-root
wp option update time_format 'H:i' --allow-root

# ユーザー追加
wp user create nobi nobi@a.com \
	--role=author \
	--user_pass=nobi
wp user create dora dora@a.com \
	--role=author \
	--user_pass=dora

telegraf --config /etc/telegraf.conf &

php-fpm7

nginx

sleep infinity