#!/usr/bin/env bash

TEMPDIR=`mktemp -d`
echo 'server.name: kibana
server.host: "0"
elasticsearch.url: '${ELASTICSEARCH_URL:-http://localhost:29200}'
xpack.security.enabled: false
xpack.reporting.enabled: false
xpack.monitoring.enabled: false' > "${TEMPDIR}/kibana.yml"

echo "Starting kibana on port 5601 using elasticsearch on ${ELASTICSEARCH_URL:-http://localhost:29200}"

docker run -it --rm --network host \
    -v "${TEMPDIR}/kibana.yml:/usr/share/kibana/config/kibana.yml" \
    docker.elastic.co/kibana/kibana:5.2.2

rm -rf "${TEMPDIR}"
