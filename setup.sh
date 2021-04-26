#!/bin/bash

# kubeコマンドとminikubeコマンド実行時の権限変更
# chmod -R 777 ~/.minikube
# chmod -R 777 ~/.kube

# eval export DOCKER_TLS_VERIFY="";export DOCKER_HOST="";export DOCKER_CERT_PATH="";export MINIKUBE_ACTIVE_DOCKERD=""

# minikube stop
# sudo minikube start --vm-driver=none --extra-config=apiserver.service-node-port-range=1-65535


minikube start driver=docker

# metalLBの起動
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb-system.yaml

eval $(minikube docker-env)

docker build -t tjinichi/nginx:000 ./srcs/nginx
docker build -t tjinichi/mysql:000 ./srcs/mysql
docker build -t tjinichi/phpmyadmin:000 ./srcs/phpmyadmin
docker build -t tjinichi/wordpress:000 ./srcs/wordpress
docker build -t tjinichi/ftps:000 ./srcs/ftps
docker build -t tjinichi/influxdb:000 ./srcs/influxdb
docker build -t tjinichi/grafana:000 ./srcs/grafana


kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f srcs/ftps/ftps.yaml
kubectl apply -f srcs/influxdb/influxdb.yaml
kubectl apply -f srcs/grafana/grafana.yaml
# kubectl apply -f ./srcs/nginx/nginx-replicaset.yaml


#ダッシュボードを起動
# sudo minikube dashboard








# minikube delete && bash setup.sh

# kubectl delete -f srcs/nginx/nginx.yaml
