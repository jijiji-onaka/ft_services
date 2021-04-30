#!/bin/sh

if ! pgrep grafana-server ; then
	exit 1
fi

if ! pgrep telegraf ; then
	exit 1
fi
