#!/bin/sh

nginx

telegraf --config /etc/telegraf.conf &

sleep infinity