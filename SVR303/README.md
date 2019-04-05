# SVR303

Build Solutions With Serverless on Kubernetes Engine

## Reset

Run this before each demo to set know state

```shell
# Delete PubSub push subscription
gcloud pubsub subscriptions delete cloud-build-push-notif-demo

# Delete Notification Service in CR
gcloud beta run services delete pubsubnotifs

# Delete Knative Eventing Sources (subscriptions in PubSub)

```

Also, reset the Cloud Run KLogo service to `External`

https://console.cloud.google.com/run/detail/cluster/us-west1-c/next/next/klogo/general?project=s9-demo



## Demos

### Demo 1

* MaxpPime (http://maxprime.next.demome.tech/)
  * Highlight release number
  * Follow link to github (https://github.com/mchmarny/maxprime)
  * Create a release (release-v0.0.*)
  * Show build file (/deployments/next-demo-build.yaml)
* Cloud Build in console (https://console.cloud.google.com/cloud-build/builds?project=s9-demo)
  * Show build progress (don't watch, will take longer)
* Switch to slide for overview (https://docs.google.com/presentation/d/16bKzW04hsjUQn6kJpwwCT7XuknJF1cL1Hue8M3xZBSo/edit?pli=1#slide=id.g557063e379_3_162)
* Back to browser to show new version in maxprime (http://maxprime.next.demome.tech/)


### Demo 2

* Cloud Build publishes status to PubSub (global, simple, reliable MQ)
* In this demo we will:
  * Create PubSub Push Subscription
  * Deploy Notification Service (custom)
* Notification Service source (https://github.com/mchmarny/pubsubnotifs)
  * Handler (receives Build status from PubSub push)
  * Sender (send builds Slack message from status and sends)
* Deploy to Cloud Run (highlight env vars, shared token)

```shell
gcloud beta run deploy pubsubnotifs \
    --image gcr.io/s9-demo/build-notif:latest \
    --set-env-vars=NOTIFS_FOR_APP=maxprime,SLACK_API_TOKEN=$SLACK_API_TOKEN,SLACK_BUILD_STATUS_CHANNEL=$SLACK_CHANNEL,KNOWN_PUBLISHER_TOKENS=$KNOWN_PUBLISHER_TOKENS
```

* Create PubSub Push Subscription

```shell
gcloud pubsub subscriptions create cloud-build-push-notif-demo \
    --topic=cloud-builds --ack-deadline=60 \
    --push-endpoint=https://pubsubnotifs.next.demome.tech/push?token=$KNOWN_PUBLISHER_TOKENS
```

* Repeat release tagging process
  * GitHub (https://github.com/mchmarny/maxprime)
  * Create a release (release-v0.0.*)
* Overview, builds on previous use-case (https://docs.google.com/presentation/d/16bKzW04hsjUQn6kJpwwCT7XuknJF1cL1Hue8M3xZBSo/edit?pli=1#slide=id.g557063e379_3_674)
* Cloud Build in console (https://console.cloud.google.com/cloud-build/builds?project=s9-demo)
  * Show build progress (don't watch, will take longer, ~1.5min)
* Slack to show the notification
  * Use slack link to navigate to build history


### Demo 3

* Setup microservice use-case (https://docs.google.com/presentation/d/16bKzW04hsjUQn6kJpwwCT7XuknJF1cL1Hue8M3xZBSo/edit?pli=1#slide=id.g55d2018883_1_612)
* Demo service
  * Show image (https://storage.googleapis.com/kdemo-logos/0.png)
  * Run image through service and show "Google" identified

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "next-demo", "url": "https://storage.googleapis.com/kdemo-logos/0.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

* Illustrate problem statement (credits)
  * Fronting UI App to Auth (https://docs.google.com/presentation/d/16bKzW04hsjUQn6kJpwwCT7XuknJF1cL1Hue8M3xZBSo/edit?pli=1#slide=id.g54f31d07c4_0_1030)
  * Show UI (https://kdemo.next.demome.tech/)
  * Show circumventing Auth by direct Logo service access (https://docs.google.com/presentation/d/16bKzW04hsjUQn6kJpwwCT7XuknJF1cL1Hue8M3xZBSo/edit?pli=1#slide=id.g55ef51deb0_1_54)

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "next-demo", "url": "https://storage.googleapis.com/kdemo-logos/0.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

* Navigate to Cloud Front UI (https://console.cloud.google.com/run/detail/cluster/us-west1-c/next/next/klogo/revisions?project=s9-demo)
  * Go to Details and switch Connectivity to `Internal`
  * Show Logo service `HTTP/2 404` on direct access

```shell
curl -H "Content-Type: application/json" -v \
     -d '{ "id": "next-demo", "url": "https://storage.googleapis.com/kdemo-logos/0.png" }' \
     -X POST https://klogo.next.demome.tech/
```

* Show final overview of internal services (+ User Microservice to metering) and external UI (https://docs.google.com/presentation/d/16bKzW04hsjUQn6kJpwwCT7XuknJF1cL1Hue8M3xZBSo/edit?pli=1#slide=id.g55d2018883_1_586)

