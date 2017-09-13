#!/usr/bin/env bash

set -e

# http://thylong.com/ci/2016/deploying-from-travis-to-gce/

if [ ! -d "$HOME/google-cloud-sdk/bin" ]; then
    rm -rf $HOME/google-cloud-sdk
    curl https://sdk.cloud.google.com | bash
fi

# Add gcloud to $PATH
source /home/travis/google-cloud-sdk/path.bash.inc
gcloud version
gcloud --quiet components update kubectl

# Auth flow
echo $GCLOUD_KEY | base64 --decode > gcloud.json
gcloud auth activate-service-account $GCLOUD_EMAIL --key-file gcloud.json
ssh-keygen -f ~/.ssh/google_compute_engine -N ""

# deploy
bin/k8s_apply.sh
