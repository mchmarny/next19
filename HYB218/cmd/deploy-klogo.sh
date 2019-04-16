gcloud beta run deploy klogo \
    --image=gcr.io/s9-demo/klogo@sha256:c91c08d92323d8d9e2b6c899249dde343ed61997db62d58deadb946b6365663d \
    --set-env-vars=RELEASE=v0.0.5-demo,GCP_PROJECT_ID=$GCLOUD_PROJECT,GIN_MODE=release