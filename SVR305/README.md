# Generating Events from Your Internal Systems with Knative

> Make sure to [reset](#Reset) environment before demos

* [DEMO-1](DEMO-1.md)
* [DEMO-2](DEMO-2.md)

## Reset

Run this before each demo to set know state

```shell
# Delete PubSub push subscription (prevent dup notifications in Slack)
gcloud pubsub subscriptions delete cloud-build-push-notif-demo

# Demo 1
kubectl delete -f /go/src/github.com/mchmarny/knative-build-status-notifs/config/trigger.yaml -n demo

# Demo 2
kubectl delete -f /go/src/github.com/mchmarny/twitter/config/source.yaml -n demo
kubectl delete -f /go/src/github.com/mchmarny/twitter/config/trigger.yaml -n demo
```

Make sure the `build-notif-*` is already installed

```shell
kubectl get kservice -n demo | grep build-notif
```

Should return

```shell
build-notif   build-notif.demo.knative.tech   build-notif-j7nk5   build-notif-j7nk5   True
```



