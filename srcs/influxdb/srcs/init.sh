#!/bin/sh

telegraf --config /etc/telegraf.conf &

influxd -config /etc/influxdb.conf

sleep infinity