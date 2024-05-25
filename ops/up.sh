#!/usr/bin/env bash

set -e
cd "$(cd -P -- "$(dirname -- "$0")/.." && pwd -P)"

case "$(uname -s)" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    *)          MACHINE=Linux
esac

MINIKUBE_STATUS=$(minikube -p minikube status || true)
if [[ $MINIKUBE_STATUS =~ Stopped|not\ found ]]; then
  START=true
else
  START=false
fi

install -m 700 -d app/database

printf "\n\e[1;32m Start minikube \e[0m\n\n"
if [ "$START" = true ]; then
  if [ "$MACHINE" == "Mac" ]; then
      minikube -p minikube start --mount-string="$(pwd)/app:/app" --mount \
               --addons=ingress --addons=ingress-dns --addons=metrics-server \
               --driver=docker --static-ip 10.10.10.10 --ports 80:80 --ports 443:443
  else
      minikube -p minikube start --mount-string="$(pwd)/app:/app" --mount \
               --addons=ingress --addons=ingress-dns --addons=metrics-server \
               --driver=docker --static-ip 10.10.10.10
  fi
  kubectl -n ingress-nginx rollout status deployment/ingress-nginx-controller
else
  printf "\e[1;34m Minikube running \e[0m\n"
fi

printf "\n\e[1;32m Prepare configuration \e[0m\n\n"
kubectl apply -f ops/cluster/dev/dev-service-account.yaml
kubectl apply -f ops/cluster/dev/ghcr-secret.yaml
kubectl apply -f ops/cluster/dev/tls-secret.yaml
printf "\n\e[1;32m Deploy database \e[0m\n\n"
kubectl apply -f ops/cluster/dev/database-deployment.yaml
kubectl rollout status deployment/database
printf "\n\e[1;32m Deploy mail service \e[0m\n\n"
kubectl apply -f ops/cluster/dev/mail-deployment.yaml
kubectl rollout status deployment/mail
printf "\n\e[1;32m Deploy applications \e[0m\n\n"
kubectl apply -f ops/cluster/dev/servicea-deployment.yaml
kubectl rollout status deployment/servicea
kubectl apply -f ops/cluster/dev/serviceb-deployment.yaml
kubectl rollout status deployment/serviceb
kubectl apply -f ops/cluster/dev/serviced-deployment.yaml
kubectl rollout status deployment/serviced

printf "\n\e[1;32m Done 🎉 \e[0m\n\n"
