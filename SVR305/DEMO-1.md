# Generating Events from Your Internal Systems with Knative

> Note, this demo has some project specific dependencies. When possible I identified these in comments or defined them as environment variable to allow you to easily replace them. Still, in some cases like custom domain you will have to substitute `*.next.demome.tech` for your own domain or Slack channel for one that actually exists in your team. Please open an issue if you come across any other... issue.

## Demo 1 - Cloud Build status event triggering Knative service

![Cloud Build Integration with Slack Notifications](img/demo1.png "Cloud Build Integration with Slack Notifications")

### Setup (open in browser) 

* Notification service (https://github.com/mchmarny/knative-build-status-notifs):
* Release tag in GitHub (https://github.com/mchmarny/maxprime)
* Cloud Build status (https://console.cloud.google.com/cloud-build/builds?project=s9-demo)

### Notification service

Source code (https://github.com/mchmarny/knative-build-status-notifs):
* **Handler** - extracts Cloud Build notification from received Cloud Event
* **Sender** - creates message from Cloud Build notification and sends it to Slack

> The `build-notif` expects `POST`, still you can check if it is installed by goign to https://build-notif.demo.knative.tech/ (`Invalid request` expected)

### Trigger

Apply following YAML (`config/trigger.yaml`)

```yaml
apiVersion: eventing.knative.dev/v1alpha1
kind: Trigger
metadata:
  name: slacker-build-status-notifier
spec:
  subscriber:
    ref:
      apiVersion: serving.knative.dev/v1alpha1
      kind: Service
      name: build-notif
```

Using `kubectl`

```shell
kubectl apply -f config/trigger.yaml -n demo
```

Should return

```shell
trigger.eventing.knative.dev/slacker-build-status-notifier created
```

Verify that `slacker-build-status-notifier` trigger was created

```shell
kubectl get triggers -n demo
```

Should return

```shell
NAME                           READY     REASON    BROKER    SUBSCRIBER_URI                               AGE
slacker-build-status-notifier  True                default   http://build-notif.demo.svc.cluster.local/   37s
```

### Execute

* Create a release tag (e.g. release-v0.0.*) in GitHub (https://github.com/mchmarny/maxprime/releases/new)
* Check Cloud Build for build status (https://console.cloud.google.com/cloud-build/builds?project=s9-demo)
* View notification in Slack (#build-status)


