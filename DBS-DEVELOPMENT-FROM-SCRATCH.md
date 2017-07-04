# How to set-up the full dbs environment for development

At the end of this guide you will have a full dbs environment running and connected between all repositories - 

from pipelines to elasticsearch to dbs-back to dbs-front

## Elasticsearch / Kibana

* You should install Elasticsearch / Kibana - latest version (5.4 at time of writing)
* Check the Elasticsearch / Kibana docs for installation instructions, for Ubunutu you should use the repository method - it's easiest.

When done, you should have:

* Elasticsearch and kibana running (you need to have the host and port - accessible from the local PC)

## dbs-back - for Elasticsearch indexing

We use dbs-back project to create the Elasticsearch index, which should be done before running the pipelines

setup the dbs-back development environment using the README - https://github.com/Beit-Hatfutsot/dbs-back/blob/dev/README.md

basically, you will need to:
* fork and clone the dbs-back repository
* create a virtualenv

to create the elasticsearch index, run the following inside the activated virtualenv:
```
PYTHONPATH=. scripts/elasticsearch_create_index.py
```

This assumes you didn't override any app configurations, so it will use default of Elasticsearch on localhost:9200 and index `bhdata`

If you use a different index or Elasticsearch is running elsewhere, use the --index and --host arguments to modify the defaults.

## mojp-dbs-pipelines

* follow the [Contributing Guide](https://github.com/Beit-Hatfutsot/mojp-dbs-pipelines/blob/master/CONTRIBUTING.md)
* run the pipelines dashboard with `dpp serve`
* pipelines themselves must run manually with e.g. `dpp run ./clearmash_places`

## dbs-back

Once pipelines ran and updated data to a correctly indexed elasticsearch - the backend can now serve API calls over Elasticsearch

You just need to make sure app configuration is correct and points to the right elasticsearch and index

```
cd dbs-back
PYTHONPATH=. scripts/runserver.py
```

(make sure pipelines dashboard is not running as well on the same port 5000)

## dbs-front

Follow this guide to setup the frontend: https://github.com/Beit-Hatfutsot/dbs-front/blob/dev/README.md

Once you have everything setup, you can run it against your local dbs-back like so:

```
cd dbs-front
nvm use   # if you are using nvm to manage node version, which I recommend
API_SERVER=local gulp serve
```

Now you can see the site at http://localhost:3000
