#!/usr/bin/env bash

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

if [ ! -f app_server.yaml ] || [ ! -f front-nginx-prerender.conf ]; then
    echo "you must create these files: app_server.yaml, front-nginx-prerender.conf"
    exit 1
else
    kubectl delete secret etc-bhs
    kubectl create secret generic etc-bhs --from-file app_server.yaml --from-file front-nginx-prerender.conf
    kubectl describe secret etc-bhs
fi
