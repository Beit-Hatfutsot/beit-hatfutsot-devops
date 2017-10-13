#!/usr/bin/env bash

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

if [ "${1}" == "" ]; then
    echo "usage: bin/k8s_force_update.sh <deployment_name>"
    exit 1
else
    kubectl patch deployment "${1}" -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
    kubectl rollout status deployment "${1}"
    exit 0
fi
