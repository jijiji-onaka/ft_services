#!/bin/bash

# kubeコマンドとminikubeコマンド実行時の権限変更
# chmod -R 777 ~/.minikube
# chmod -R 777 ~/.kube

# eval export DOCKER_TLS_VERIFY="";export DOCKER_HOST="";export DOCKER_CERT_PATH="";export MINIKUBE_ACTIVE_DOCKERD=""

# minikube stop
# sudo minikube start --vm-driver=none --extra-config=apiserver.service-node-port-range=1-65535

COLOR_1="\033[38;5;44m"
COLOR_2="\033[38;5;48m"
COLOR_RESET="\033[0m"

minikube start driver=docker

# metalLBの起動
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml > /dev/null
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml > /dev/null
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" > /dev/null
kubectl apply -f ./srcs/metallb/metallb-system.yaml > /dev/null

eval $(minikube docker-env)
printf "${COLOR_1} [ docker build ] ${COLOR_RESET}\n"
printf "${COLOR_1} building nginx ... ${COLOR_RESET}\n"
docker build -t tjinichi/nginx:000 ./srcs/nginx > /dev/null
printf "${COLOR_1} building mysql ... ${COLOR_RESET}\n"
docker build -t tjinichi/mysql:000 ./srcs/mysql > /dev/null
printf "${COLOR_1} building phpmyadmin ... ${COLOR_RESET}\n"
docker build -t tjinichi/phpmyadmin:000 ./srcs/phpmyadmin > /dev/null
printf "${COLOR_1} building wordpress ... ${COLOR_RESET}\n"
docker build -t tjinichi/wordpress:000 ./srcs/wordpress > /dev/null
printf "${COLOR_1} building ftps ... ${COLOR_RESET}\n"
docker build -t tjinichi/ftps:000 ./srcs/ftps > /dev/null
printf "${COLOR_1} building influxdb ... ${COLOR_RESET}\n"
docker build -t tjinichi/influxdb:000 ./srcs/influxdb > /dev/null
printf "${COLOR_1} building grafana ... ${COLOR_RESET}\n"
docker build -t tjinichi/grafana:000 ./srcs/grafana > /dev/null


printf "${COLOR_2} [ kubectl apply ] ${COLOR_RESET}\n"
printf "${COLOR_2} apply nginx ... ${COLOR_RESET}\n"
kubectl apply -f ./srcs/nginx/nginx.yaml > /dev/null
printf "${COLOR_2} apply mysql ... ${COLOR_RESET}\n"
kubectl apply -f ./srcs/mysql/mysql.yaml > /dev/null
printf "${COLOR_2} apply phpmyadmin ... ${COLOR_RESET}\n"
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml > /dev/null
printf "${COLOR_2} apply wordpress ... ${COLOR_RESET}\n"
kubectl apply -f ./srcs/wordpress/wordpress.yaml > /dev/null
printf "${COLOR_2} apply ftps ... ${COLOR_RESET}\n"
kubectl apply -f srcs/ftps/ftps.yaml > /dev/null
printf "${COLOR_2} apply influxdb ... ${COLOR_RESET}\n"
kubectl apply -f srcs/influxdb/influxdb.yaml > /dev/null
printf "${COLOR_2} apply grafana ... ${COLOR_RESET}\n"
kubectl apply -f srcs/grafana/grafana.yaml > /dev/null
# kubectl apply -f ./srcs/nginx/nginx-replicaset.yaml


#ダッシュボードを起動
# sudo minikube dashboard








# minikube delete && bash setup.sh

# kubectl delete -f srcs/nginx/nginx.yaml
