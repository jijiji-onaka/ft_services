#!/bin/sh

mysql_install_db --user=root --datadir=/var/lib/mysql

cat > /tmp/create_table.sql << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wpdb;
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS test;
EOF

/usr/bin/mysqld --user=root --datadir=/var/lib/mysql --bootstrap < /tmp/create_table.sql
rm -f /tmp/create_table.sql

telegraf --config /etc/telegraf.conf &

/usr/bin/mysqld_safe --user=root --datadir=/var/lib/mysql

tail -f