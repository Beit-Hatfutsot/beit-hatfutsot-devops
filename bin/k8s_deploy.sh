#!/usr/bin/env bash

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

if [ "${1}" == "" ] || [ "${2}" == "" ]; then
    echo "usage: bin/k8s_deploy.sh <deploynemt_name> <image_name>"
else
    kubectl set image "deployment/${1}" "${1}=${2}" && kubectl rollout status "deployment/${1}"
fi
