#!/bin/bash

# kubeコマンドとminikubeコマンド実行時の権限変更
# chmod -R 777 ~/.minikube
# chmod -R 777 ~/.kube

# eval export DOCKER_TLS_VERIFY="";export DOCKER_HOST="";export DOCKER_CERT_PATH="";export MINIKUBE_ACTIVE_DOCKERD=""

# minikube stop
# sudo minikube start --vm-driver=none --extra-config=apiserver.service-node-port-range=1-65535

COLOR_MSG="\033[38;5;44m"
COLOR_RESET="\033[0m"

minikube start driver=docker

# metalLBの起動
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml > /dev/null
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml > /dev/null
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
kubectl apply -f ./srcs/metallb/metallb-system.yaml > /dev/null

eval $(minikube docker-env)
printf "${COLOR_MSG} [ docker build ] ${COLOR_RESET}\n"
printf "${COLOR_MSG} building nginx ... ${COLOR_RESET}\n"
docker build -t tjinichi/nginx:000 ./srcs/nginx > /dev/null
printf "${COLOR_MSG} building mysql ... ${COLOR_RESET}\n"
docker build -t tjinichi/mysql:000 ./srcs/mysql > /dev/null
printf "${COLOR_MSG} building phpmyadmin ... ${COLOR_RESET}\n"
docker build -t tjinichi/phpmyadmin:000 ./srcs/phpmyadmin > /dev/null
printf "${COLOR_MSG} building wordpress ... ${COLOR_RESET}\n"
docker build -t tjinichi/wordpress:000 ./srcs/wordpress > /dev/null
printf "${COLOR_MSG} building ftps ... ${COLOR_RESET}\n"
docker build -t tjinichi/ftps:000 ./srcs/ftps > /dev/null
printf "${COLOR_MSG} building influxdb ... ${COLOR_RESET}\n"
docker build -t tjinichi/influxdb:000 ./srcs/influxdb > /dev/null
printf "${COLOR_MSG} building grafana ... ${COLOR_RESET}\n"
docker build -t tjinichi/grafana:000 ./srcs/grafana > /dev/null


printf "${COLOR_MSG} [ kubectl apply ] ${COLOR_RESET}\n"
printf "${COLOR_MSG} apply nginx ... ${COLOR_RESET}\n"
kubectl apply -f ./srcs/nginx/nginx.yaml > /dev/null
printf "${COLOR_MSG} apply mysql ... ${COLOR_RESET}\n"
kubectl apply -f ./srcs/mysql/mysql.yaml > /dev/null
printf "${COLOR_MSG} apply phpmyadmin ... ${COLOR_RESET}\n"
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml > /dev/null
printf "${COLOR_MSG} apply wordpress ... ${COLOR_RESET}\n"
kubectl apply -f ./srcs/wordpress/wordpress.yaml > /dev/null
printf "${COLOR_MSG} apply ftps ... ${COLOR_RESET}\n"
kubectl apply -f srcs/ftps/ftps.yaml > /dev/null
printf "${COLOR_MSG} apply influxdb ... ${COLOR_RESET}\n"
kubectl apply -f srcs/influxdb/influxdb.yaml > /dev/null
printf "${COLOR_MSG} apply grafana ... ${COLOR_RESET}\n"
kubectl apply -f srcs/grafana/grafana.yaml > /dev/null
# kubectl apply -f ./srcs/nginx/nginx-replicaset.yaml


#ダッシュボードを起動
# sudo minikube dashboard








# minikube delete && bash setup.sh

# kubectl delete -f srcs/nginx/nginx.yaml
