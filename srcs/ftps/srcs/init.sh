#!/bin/sh

adduser -D "test"
echo "test:test" | chpasswd

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf

tail -f