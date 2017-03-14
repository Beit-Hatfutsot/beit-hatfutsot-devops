#!/usr/bin/env bash

if [ "${*}" == "" ] || [ "${*}" == "--help" ] || [ "${*}" == "-h" ]; then
    echo "start an ssh tunnel to kibana (local port=25601, remote port=5601)"
    echo "Usage:"
    echo "bin/kibana_ssh_tunnel.sh <HOST>"
    echo "  HOST = the gcloud compute host name"
else
    gcloud compute ssh "${1}" -- -L 25601:localhost:5601
fi
