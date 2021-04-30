#!/bin/sh

if ! pgrep nginx ; then
	exit 1
fi

if ! pgrep telegraf ; then
	exit 1
fi
