#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

mysql_install_db --user=root --datadir=/var/lib/mysql

mysql_install_db --user=root > /dev/null

cat > /tmp/create_table.sql << EOF
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wpdb;
CREATE USER 'admin'@'%' identified by 'admin';
GRANT ALL PRIVILEGES ON wpdb.* TO 'admin'@'%';
FLUSH PRIVILEGES;
EOF

/usr/bin/mysqld --user=root --bootstrap --verbose=0 < /tmp/create_table.sql

exec /usr/bin/mysqld --user=root --console
