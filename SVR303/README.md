# SVR303 - Build Solutions With Serverless on Kubernetes Engine

> Make sure to [reset](#Reset) environment before demos

## Demos

* [DEMO-1](DEMO-1.md)
* [DEMO-2](DEMO-2.md)
* [DEMO-3](DEMO-3.md)

Open tabs:

Mike:
* [Tab 1](http://aerial-tiler.default.130.211.124.0.xip.io/preview?url=gs://3f23a0a4-3381-4382-b273-9f45e936b91b/analytics-ready/pansharpened/DIM_SPOT6_PMS_201809181528155_ORT_3317561101.tif#14/35.28942974756265/-77.58146996050691)
* [Tab 2](http://aerial-tiler.default.130.211.124.0.xip.io/preview?url=gs://3f23a0a4-3381-4382-b273-9f45e936b91b/analytics-ready/pansharpened/DIM_SPOT6_PMS_201809181528155_ORT_3317561101.tif&pmin=2&pmax=98&linearStretch=true#14/35.28942974756265/-77.58146996050691)

Mark:
* http://maxprime.next.demome.tech/
* https://console.cloud.google.com/cloud-build/builds?project=s9-demo
* https://github.com/mchmarny/maxprime
* https://github.com/mchmarny/pubsubnotifs

## Reset

Run this before each demo to set know state

```shell
# Delete PubSub push subscription
gcloud pubsub subscriptions delete cloud-build-push-notif-demo

# Delete Notification Service in CR
gcloud beta run services delete pubsubnotifs

# Delete Knative Eventing Sources (subscriptions in PubSub, prevent dup notifications)
gcloud container clusters get-credentials kn-05
kubectl delete -f /go/src/github.com/mchmarny/knative-build-status-notifs/config/trigger.yaml -n demo

# Switch to the Cloud Run context
gcloud container clusters get-credentials next
```

Also, reset the Cloud Run KLogo service to `External`

https://console.cloud.google.com/run/detail/cluster/us-west1-c/next/next/klogo/general?project=s9-demo

