# SVR303 - Build Solutions With Serverless on Kubernetes Engine

> Make sure to [reset](#Reset) environment before demos

## Demos

* [DEMO-1](DEMO-1.md)
* [DEMO-2](DEMO-2.md)
* [DEMO-3](DEMO-3.md)

## Reset

Run this before each demo to set know state

```shell
# Delete PubSub push subscription
gcloud pubsub subscriptions delete cloud-build-push-notif-demo

# Delete Notification Service in CR
gcloud beta run services delete pubsubnotifs

# Delete Knative Eventing Sources (subscriptions in PubSub, prevent dup notifications)
kubectl delete -f /go/src/github.com/mchmarny/knative-build-status-notifs/config/trigger.yaml -n demo
```

Also, reset the Cloud Run KLogo service to `External`

https://console.cloud.google.com/run/detail/cluster/us-west1-c/next/next/klogo/general?project=s9-demo

