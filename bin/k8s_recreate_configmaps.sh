#!/usr/bin/env bash

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

set -e

kubectl delete configmap nginx-conf-d
kubectl create configmap nginx-conf-d --from-file=./k8s/nginx-default.conf
kubectl describe configmap nginx-conf-d
