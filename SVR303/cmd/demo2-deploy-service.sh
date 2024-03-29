gcloud beta run deploy pubsubnotifs \
    --image=gcr.io/s9-demo/pubsubnotifs@sha256:d12b2403d0a3a7cdb401e5a7c2e98f66cd811d9dc18ef6d8bf5971831f4cb919 \
    --set-env-vars=NOTIFS_FOR_APP=maxprime,SLACK_API_TOKEN=$SLACK_API_TOKEN,SLACK_BUILD_STATUS_CHANNEL=$SLACK_BUILD_STATUS_CHANNEL,KNOWN_PUBLISHER_TOKENS=$KNOWN_PUBLISHER_TOKENS