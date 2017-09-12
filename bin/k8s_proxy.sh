#!/usr/bin/env bash

"${BEIT_HATFUTSOT_DEVOPS_DIR:-`pwd`}/bin/k8s_connect.sh"

kubectl proxy
