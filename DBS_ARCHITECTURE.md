# High level architecture of the databases project

## Code repositories

* [https://github.com/Beit-Hatfutsot/dbs-back](dbs-back) - web app backend (Python 2.7 / Flask)
* [https://github.com/Beit-Hatfutsot/dbs-front](dbs-front) - web app frontend (Angular 1.4)
* [https://github.com/Beit-Hatfutsot/mojp-dbs-pipelines](mojp-dbs-pipelines) - sync services (Python 3.6)

## Database

We use Elasticsearch 5.4 as the main data storage and search engine.

It is populated and updated by the sync services.

Index mapping is done from dbs-back, according to the search requirements (see [scripts/elasticsearch_create_index.py](https://github.com/Beit-Hatfutsot/dbs-back/blob/dev/scripts/elasticsearch_create_index.py))

## Environments and servers

### Dev Environment

* server `bhs-dev-3` - runs all the web apps and the sync services
* database server `bhs-dev-db` - runs the elasticsearch instance

### Production Environment

* server `bhs-prod` - runs all the web apps and the sync services
* database server `bhs-prod-db` - runs the elasticsearch instance
