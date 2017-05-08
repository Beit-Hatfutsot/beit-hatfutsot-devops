# Beit Hatfutsot databases project - Elasticsearch

The databases project Elasticsearch instance contains the following `collections`:

* photoUnits
* familyNames
* places
* personalities
* movies

All collections are stored on a single Elasticsearch index, each collection corresponds to an Elasticsearhc document type.

## Index management

Currently (as of Mar. 14, 2017) the [dump_mongo_to_es.py](https://github.com/Beit-Hatfutsot/dbs-back/blob/dev/scripts/dump_mongo_to_es.py) script drops and creates the index on each run.

You can see the latest index definition (exported from production instance on Mar. 14, 2017) here - [/databases/elasticsearch_index_dump.json]

## Servers / Environments

### production

* Hosted on `mongo1-dev` (port 9200)
  * index name = "mojp-live"

### dev

* Hosted on `bhs-dev-db` (port 9200)
  * index name = "mojp-dev"

## Elasticsearch installation notes

### using docker

install docker

```
curl -fsSL https://get.docker.com/ | sh
```

set some environment variables - modify according to the instance you are setting up

```
export ES_DATA_DIR="/data/bh-dev-es/data"
export ES_CONFIG_DIR="/data/bh-dev-es/config"
export ES_EXPOSED_PORT="9200"
export ES_DOCKER_NAME="dev-es"
export ES_DOCKER_IMAGE="docker.elastic.co/elasticsearch/elasticsearch:5.2.2"
```

create the elasticsearch directory structure

```
sudo mkdir -p "${ES_DATA_DIR}"
sudo mkdir -p "${ES_CONFIG_DIR}"
```

create the configuration files in ES_CONFIG_DIR, you can base it on [/databases/elasticsearch_config](/databases/elasticsearch_config)

possible configuration modifications:

* set the Xms / Xmx options for memory size in jvm.options file
* add the following to elasticsearch.yml to allow anonymous access
```
# allow anonymous access (we are behind firewall)
xpack.security.authc:
  anonymous:
    roles: superuser
    authz_exception: true
```

install and run

```
if ! grep vm.max_map_count /etc/sysctl.conf; then echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf; fi
sudo sysctl -w vm.max_map_count=262144
sudo chown -R 1000 "${ES_DATA_DIR}"
sudo docker pull "${ES_DOCKER_IMAGE}"
sudo docker run -d -v "${ES_DATA_DIR}:/usr/share/elasticsearch/data" -v "${ES_CONFIG_DIR}:/usr/share/elasticsearch/config" -p "${ES_EXPOSED_PORT}:9200" --restart=always --name "${ES_DOCKER_NAME}" "${ES_DOCKER_IMAGE}"
```

kibana environment variables

```
export ES_KIBANA_DOCKER_NAME="dev-kibana"
export ES_KIBANA_DOCKER_IMAGE="docker.elastic.co/kibana/kibana:5.2.2"
export ES_KIBANA_CONFIG_DIR="/data/bh-dev-es/kibana-config"
```

create the configuration files in ES_KIBANA_CONFIG_DIR, you can base it on [/databases/kibana_config](/databases/kibana_config)

modify relevant settings in kibana.yml, most importantly the elasticsearch url

also, if you want to disable security, add `xpack.security.enabled: false` to kibana.yml

install and run kibana

```
sudo docker pull "${ES_KIBANA_DOCKER_IMAGE}"
sudo docker run -d --net=host -v "${ES_KIBANA_CONFIG_DIR}:/usr/share/kibana/config" --name "${ES_KIBANA_DOCKER_NAME}" "docker.elastic.co/kibana/kibana:5.2.2"
```

## importing data

install elasticdump

```
sudo apt-get install nodejs npm
sudo npm install -g elasticdump
sudo ln -s /usr/bin/nodejs /usr/bin/node
```

find out the input and output elasticsearch instance urls and index name

you can use a command like this to find out which indices are available `curl http://localhost:9200/_cat/indices`

set some environment variables we will use in later commands

```
export INPUT_ES_INDEX_URL="http://remote.host:9200/remote_index_name"
export OUTPUT_ES_INDEX_URL="http://localhost:9200/local_index_name"
```

make sure you have access to both elasticsearch instances

```
curl $INPUT_ES_INDEX_URL
curl $OUTPUT_ES_INDEX_URL
```

run the import (depending on what you want to do, see elasticdump documentation for details)

```
elasticdump --input=${INPUT_ES_INDEX_URL} --output=${OUTPUT_ES_INDEX_URL} --type=analyzer
elasticdump --input=${INPUT_ES_INDEX_URL} --output=${OUTPUT_ES_INDEX_URL} --type=mapping
elasticdump --input=${INPUT_ES_INDEX_URL} --output=${OUTPUT_ES_INDEX_URL} --type=data
```

## re-indexing

you can use the same importing process to do reindexing of existing data

before you start you should create the new index with new mapping

you will have to create a new index, and then point your app to the new index

if this is a problem, you should consider create an alias which will point to the latest index

you can use the dbs-back scripts/elasticsearch_create_index.py command to create a new index

```
(dbs-back) dbs-back$ scripts/elasticsearch_create_index.py --index new_index_name
```

make sure new data is not written to the old index (if it's important to prevent data inconsistencies)

you can use elasticdump to copy over the data to the new index:

```
export INPUT_ES_INDEX_URL="http://localhost:9200/old_index"
export OUTPUT_ES_INDEX_URL="http://localhost:9200/new_index"
elasticdump --input=${INPUT_ES_INDEX_URL} --output=${OUTPUT_ES_INDEX_URL} --type=data
```
