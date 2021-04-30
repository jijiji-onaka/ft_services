#!/bin/sh

if ! pgrep vsftpd ; then
	exit 1
fi

if ! pgrep telegraf ; then
	exit 1
fi
