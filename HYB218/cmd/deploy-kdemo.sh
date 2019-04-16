gcloud beta run deploy kdemo \
    --image=gcr.io/s9-demo/kdemo@sha256:740d51b53e218d48eb9764b6f246d3a4393ff614ec15cd4463a841d2c2676a32 \
    --set-env-vars=RELEASE=v0.0.6-demo,FORCE_HTTPS=yes,OAUTH_CLIENT_ID=$DEMO_OAUTH_CLIENT_ID,OAUTH_CLIENT_SECRET=$DEMO_OAUTH_CLIENT_SECRET,GCP_PROJECT_ID=s9-demo,KLOGO_SERVICE_URL=http://klogo.next.svc.cluster.local,KUSER_SERVICE_URL=http://kuser.next.svc.cluster.local