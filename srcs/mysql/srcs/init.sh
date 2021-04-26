#!/bin/sh

# chown -R mysql:mysql /var/lib/mysql

mysql_install_db --user=root --datadir=/var/lib/mysql

cat > /tmp/create_table.sql << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wpdb;
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
FLUSH PRIVILEGES;
DROP DATABASE IF EXISTS test;
EOF

# GRANT ALL PRIVILEGES ON wpdb.* TO 'admin'@'%';

# CREATE USER 'user'@'localhost' IDENTIFIED BY 'your_password';
# GRANT ALL PRIVILEGES ON *.* To 'user'@'localhost' WITH GRANT OPTION;
# FLUSH PRIVILEGES;
# ALTER USER user IDENTIFIED WITH mysql_native_password BY
# 'your_password';

telegraf --config /etc/telegraf.conf &

/usr/bin/mysqld --user=root --datadir=/var/lib/mysql --bootstrap < /tmp/create_table.sql
rm -f /tmp/create_table.sql


/usr/bin/mysqld_safe --user=root --datadir=/var/lib/mysql

tail -f