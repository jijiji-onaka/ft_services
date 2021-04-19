#!/bin/sh -u

mysql_install_db --user=root --datadir=/var/lib/mysql > /dev/null

# /usr/bin/mysqld --user=root --console
/usr/bin/mysqld_safe --user=root --console

# tail -f
