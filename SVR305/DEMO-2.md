# Generating Events from Your Internal Systems with Knative

> Note, this demo has some project specific dependencies. When possible I identified these in comments or defined them as environment variable to allow you to easily replace them. Still, in some cases like custom domain you will have to substitute `*.next.demome.tech` for your own domain. Please open an issue if you come across any other... issue.

## Prerequisites

* Setup [Knative Serving](https://github.com/knative/docs/blob/master/docs/install)
* Setup [Knative Eventing](https://github.com/knative/docs/blob/master/docs/eventing)

## Demo 2 - How to install Twitter event source and wire it to Knative service

![Twitter event source and wire it to Knative service](img/demo2.png "Twitter event source and wire it to Knative service")

### Setup

Twitter viewer app (https://tevents.demo.knative.tech)

### UI

Open https://tevents.demo.knative.tech (should be empty if soure/trigger were cleaned up)


### Source

Apply following YAML (`config/source.yaml`)

> `--query=KnativeNextDemo` is where you can define the Twitter search term (hashtag or simple string). Secrets have already been configured.



```yaml
apiVersion: sources.eventing.knative.dev/v1alpha1
kind: ContainerSource
metadata:
  name: twitter-source
spec:
  args:
  - --query=KnativeNextDemo
  env:
  - name: TWITTER_CONSUMER_KEY
    valueFrom:
      secretKeyRef:
        key: consumer-key
        name: twitter-secret
  - name: TWITTER_CONSUMER_SECRET_KEY
    valueFrom:
      secretKeyRef:
        key: consumer-secret-key
        name: twitter-secret
  - name: TWITTER_ACCESS_TOKEN
    valueFrom:
      secretKeyRef:
        key: access-token
        name: twitter-secret
  - name: TWITTER_ACCESS_SECRET
    valueFrom:
      secretKeyRef:
        key: access-secret
        name: twitter-secret
  image: us.gcr.io/probable-summer-223122/source-7dd4982354a958712ad81ca4a42243dd@sha256:9bfa60a5d6edaedd5431d751595b54b1282a3f4e7b512a6bb6784e8be4699a5c
  sink:
    apiVersion: eventing.knative.dev/v1alpha1
    kind: Broker
    name: default

```

Using `kubectl`

```shell
kubectl apply -f config/source.yaml -n demo
```

Should return

```shell
containersource.sources.eventing.knative.dev/twitter-source created
```

Verify that `twitter-source` source was created

```shell
kubectl get sources -n demo
```

Should return

```shell
NAME             AGE
twitter-source   1d
```

### Trigger

Applying following YAML (`config/trigger.yaml`)

> Notice the `type: com.twitter` filter

```yaml
apiVersion: eventing.knative.dev/v1alpha1
kind: Trigger
metadata:
  name: twitter-events-viewer
spec:
  filter:
    sourceAndType:
      type: com.twitter
  subscriber:
    ref:
      apiVersion: serving.knative.dev/v1alpha1
      kind: Service
      name: tevents
```

Using `kubectl`

```shell
kubectl apply -f config/trigger.yaml -n demo
```

Should return

```shell
trigger.eventing.knative.dev/twitter-events-viewer created
```

Verity that `twitter-events-viewer` trigger was created

```shell
kubectl get triggers -n demo
```

Should return

```shell
NAME                    READY   REASON    BROKER    SUBSCRIBER_URI                               AGE
twitter-events-viewer   True              default   http://build-notif.demo.svc.cluster.local/   37s
```

### Execute

View UI again (https://tevents.demo.knative.tech)


> Ask audience to tweet something with the term defined in the source's `--query=KnativeNextDemo` argument. Note, this could result in some NSFW tweets being displayed!


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



