#!/bin/sh

if ! pgrep mysqld ; then
	exit 1
fi

if ! pgrep telegraf ; then
	exit 1
fi
