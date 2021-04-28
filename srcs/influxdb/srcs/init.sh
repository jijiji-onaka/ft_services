#!/bin/sh

influxd -config /etc/influxdb.conf &

telegraf --config /etc/telegraf.conf &

sleep infinity
