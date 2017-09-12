#!/usr/bin/env bash

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

kubectl apply -f k8s/back.yaml -f k8s/front.yaml -f k8s/nginx.yaml -f k8s/redis.yaml

