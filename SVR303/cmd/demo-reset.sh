gcloud pubsub subscriptions delete cloud-build-push-notif-demo
gcloud beta run services delete pubsubnotifs
gcloud container clusters get-credentials kn-05
kubectl delete -f /go/src/github.com/mchmarny/knative-build-status-notifs/config/trigger.yaml -n demo
gcloud container clusters get-credentials next