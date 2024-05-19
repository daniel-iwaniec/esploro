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
printf "\n\e[1;32m Deploy applications \e[0m\n\n"
kubectl apply -f ops/cluster/dev/servicea-deployment.yaml
kubectl rollout status deployment/servicea

printf "\n\e[1;32m Done 🎉 \e[0m\n\n"