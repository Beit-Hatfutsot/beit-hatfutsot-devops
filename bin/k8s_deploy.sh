#!/usr/bin/env bash

set -e

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

echo " > Applying configurations"
bin/k8s_apply.sh


echo " > waiting 10 seconds"  # for deployment to complete and to make sure we check the status of the new deployment
sleep 10

echo " > Waiting for successful rollout status"
kubectl rollout status -w deployment/back
kubectl rollout status -w deployment/front
kubectl rollout status -w deployment/nginx
kubectl rollout status -w deployment/redis
