#!/bin/sh

adduser -D "test"
echo "test:test" | chpasswd

telegraf --config /etc/telegraf.conf &

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

tail -f