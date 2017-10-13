#!/usr/bin/env bash

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

if [ "${1}" == "minio-data" ]; then
    gcloud --project bh-org-01 compute disks create --size 10GB dbs-prod-minio-data
    exit 0

elif [ "${1}" == "env-vars-secrets" ]; then
    if [ ! -f "secrets.env" ]; then
        echo " > missing secrets file: secrets.env"
        exit 1
    fi
    kubectl delete secret env-vars
    while ! timeout 4s kubectl create secret generic env-vars --from-env-file "secrets.env"; do
        sleep 1
    done
    exit 0

fi

echo " > ERROR! unknown provision ${1}"
exit 1
