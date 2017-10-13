#!/usr/bin/env bash

set -e

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

kubectl apply -f k8s/back.yaml \
              -f k8s/front.yaml \
              -f k8s/nginx.yaml \
              -f k8s/redis.yaml \
              -f k8s/letsencrypt.yaml \
              -f k8s/minio.yaml \
              -f k8s/pipelines.yaml
