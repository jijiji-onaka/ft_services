#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

mysql_install_db --user=root --datadir=/var/lib/mysql

cat > /tmp/create_table.sql << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS "ft_db";
CREATE USER IF NOT EXISTS 'jijiji'@'%' IDENTIFIED BY 'abcde';
GRANT ALL PRIVILEGES ON "ft_db".* TO 'jijiji'@'%';
CREATE USER IF NOT EXISTS 'jijiji'@'%' IDENTIFIED BY 'abcde';
GRANT ALL PRIVILEGES ON *.* TO 'jijiji'@'%';
EOF

/usr/bin/mysqld --user=root --bootstrap < /tmp/create_table.sql
rm -f /tmp/create_table.sql

/usr/bin/mysqld_safe --user=root

sleep infinity
