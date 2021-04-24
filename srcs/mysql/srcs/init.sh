#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

mysql_install_db --user=root --datadir=/var/lib/mysql

# cat > /tmp/create_table.sql << EOF
# FLUSH PRIVILEGES;
# CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
# CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
# DROP DATABASE IF EXISTS test;
# EOF
cat > /tmp/create_table.sql << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS wpdb;
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON wpdb.* TO 'admin'@'%';
DROP DATABASE IF EXISTS test;
EOF

/usr/bin/mysqld --user=root --bootstrap < /tmp/create_table.sql
rm -f /tmp/create_table.sql

/usr/bin/mysqld_safe --user=root

tail -f