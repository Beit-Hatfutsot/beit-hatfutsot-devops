# Beit Hatfutsot Kubernetes Environment

The environment is hosted on Google Container Engine (GKE).

It's managed by the k8s scripts in bin/ directory.

You need to have the gcloud console installed and authenticated.

## Docker Images

* We use the private google container registry - because it's more secure and builds images faster
* Image names use the git commit sha - that way you know which version is deployed

## Continuous Deployment

Using travis:

* dbs-back and dbs-front repositories update the k8s configured image in this repo and commit the change using a bot user
* this triggers travis script that applies all the configurations to the cluster
