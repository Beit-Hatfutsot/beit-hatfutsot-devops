#!/usr/bin/env bash

if [ "${*}" == "" ] || [ "${*}" == "--help" ] || [ "${*}" == "-h" ]; then
    echo "start an ssh tunnel to internal services"
    echo "Usage:"
    echo "bin/ssh_tunnel.sh APP ENVIRONMENT_NAME"
    echo "  APP = the app to access (elasticsearch / kibana)"
    echo "  ENVIRONMENT_NAME = the enviornment (dev / prod)"
else
    APP="${1}"
    ENVIRONMENT_NAME="${2}"
    if [ "${ENVIRONMENT_NAME}" == "prod" ] && [ "${APP}" == "elasticsearch" ]; then
        GCLOUD_HOST="mongo1-dev"
        REMOTE_PORT="9200"
        LOCAL_PORT="29200"
    elif [ "${ENVIRONMENT_NAME}" == "prod" ] && [ "${APP}" == "kibana" ]; then
        GCLOUD_HOST="mongo1-dev"
        REMOTE_PORT="5601"
        LOCAL_PORT="25601"
    elif [ "${ENVIRONMENT_NAME}" == "dev" ] && [ "${APP}" == "elasticsearch" ]; then
        GCLOUD_HOST="bhs-dev-db"
        REMOTE_PORT="9200"
        LOCAL_PORT="19200"
    elif [ "${ENVIRONMENT_NAME}" == "dev" ] && [ "${APP}" == "kibana" ]; then
        GCLOUD_HOST="bhs-dev-db"
        REMOTE_PORT="5601"
        LOCAL_PORT="15601"
    else
        echo "invalid environment / app"
        exit 1
    fi
    echo "starting ssh tunnel for ${ENVIRONMENT_NAME} ${APP}"
    echo "service will be available at:"
    echo "  http://localhost:${LOCAL_PORT}"
    gcloud compute ssh "${GCLOUD_HOST}" -- -L "${LOCAL_PORT}:localhost:${REMOTE_PORT}" -nN
fi
