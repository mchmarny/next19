# next19

Setup and demo scripts for Google Cloud Next 2019

## Sessions

* [SVR206](/SVR303) - Knative a Year Later: Serverless, Kubernetes and You
* [SVR303]() - Build Solutions With Serverless on Kubernetes Engine
* [HYB218]() - Run a serverless platform anywhere with Kubernetes and Knative
* [SVR305]() - Generating Events from Your Internal Systems with Knative


## Env Setup

gcloud config (`~/.config/gcloud/configurations/config_default`)

> Replace the `account` and `project` variables

```shell
[core]
account = mchmarny@google.com
project = s9-demo

[compute]
region = us-west1
zone = us-west1-a

[run]
cluster_location = us-west1-a
namespace = next
region = us-west1
cluster = next
```

```shell
gcloud container clusters get-credentials next
```

## Change Context

For demoing between CR and Kn.

Current context

```shell
kubectl config current-context
```

Switch between clusters

```
kubectl config use-context next-demo
kubectl config use-context kn-v04
```
