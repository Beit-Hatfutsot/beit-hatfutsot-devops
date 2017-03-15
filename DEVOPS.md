# Beit Hetfutsot devops documentation

## Google cloud

We use google cloud CLI tool to ssh into servers, you should make sure it's installed and authorized to our organization.

Once it's installed you should be able to run something like this:

* `gcloud compute ssh bhs-dev`

## ssh tunnel to access internal services

check out bin/ssh_tunnel.sh to open an ssh tunnel to services

for example:

```
$ bin/ssh_tunnel.sh kibana dev
starting ssh tunnel for dev kibana
service will be available at:
  http://localhost:15601
```
