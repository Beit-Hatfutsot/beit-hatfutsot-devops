# Beit Hatfutsot Kubernetes Environment

The environment is hosted on Google Container Engine (GKE).

It's managed by the k8s scripts in bin/ directory.

You need to have the gcloud console installed and authenticated.

## Docker Images

* We use the private google container registry - because it builds images faster
* Image names use the git commit sha - that way you know which version is deployed
