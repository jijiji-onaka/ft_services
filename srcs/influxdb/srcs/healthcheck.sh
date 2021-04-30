#!/bin/sh

if ! pgrep influxd ; then
	exit 1
fi

if ! pgrep telegraf ; then
	exit 1
fi
