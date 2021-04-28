#!/bin/sh

telegraf --config /etc/telegraf.conf &

/etc/grafana/bin/grafana-server --homepath /etc/grafana

sleep infinity