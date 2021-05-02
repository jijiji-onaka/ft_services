#!/bin/bash

kubectl delete -f srcs/nginx/nginx.yaml
kubectl delete -f srcs/phpmyadmin/phpmyadmin.yaml
kubectl delete -f srcs/wordpress/wordpress.yaml
kubectl delete -f srcs/mysql/mysql.yaml
kubectl delete -f srcs/ftps/ftps.yaml
kubectl delete -f srcs/influxdb/influxdb.yaml
kubectl delete -f srcs/grafana/grafana.yaml
# kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
# kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl delete -f ./srcs/metallb/metallb-system.yaml

kubectl get all