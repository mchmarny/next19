# HYB218 - Run a serverless platform anywhere with Kubernetes and Knative

> Make sure to [reset](#Reset) environment before demos

## Demo - Microservices (External/Internal Services)

In this demo we will show simple microservice using GCP Vision API

#### Logo Service

Deploy service usign gcloud

```shell
gcloud beta run deploy klogo \
    --image=gcr.io/s9-demo/klogo@sha256:c91c08d92323d8d9e2b6c899249dde343ed61997db62d58deadb946b6365663d \
    --set-env-vars=RELEASE=v0.0.3,GCP_PROJECT_ID=s9-demo,GIN_MODE=release
```

![Microservice with Vision API on Cloud Run](../SVR303/img/ms-1.png "Microservice with Vision API on Cloud Run")

Run image (https://storage.googleapis.com/kdemo-logos/google.png)

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "logo1", "url": "https://storage.googleapis.com/kdemo-logos/google.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

#### Authentication App

```shell
gcloud beta run deploy kdemo \
    --image=gcr.io/s9-demo/kdemo@sha256:740d51b53e218d48eb9764b6f246d3a4393ff614ec15cd4463a841d2c2676a32 \
    --set-env-vars=RELEASE=v0.0.5,FORCE_HTTPS=yes,OAUTH_CLIENT_ID=$DEMO_OAUTH_CLIENT_ID,OAUTH_CLIENT_SECRET=$DEMO_OAUTH_CLIENT_SECRET,GCP_PROJECT_ID=s9-demo,KLOGO_SERVICE_URL=http://klogo.next.svc.cluster.local,KUSER_SERVICE_URL=http://kuser.next.svc.cluster.local
```

![Auth Microservice fronting Logo Service](../SVR303/img/ms-2.png "Auth Microservice fronting Logo Service")
* Demo UI (https://kdemo.next.demome.tech/)


#### Circumvent Authentication App

![Auth Microservice fronting Logo Service](../SVR303/img/ms-3.png "Auth Microservice fronting Logo Service")

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "logo2", "url": "https://storage.googleapis.com/kdemo-logos/google.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

#### Set Logo Service as "Internal"

Set connectivity in details to `Internal` in Cloud Run (https://console.cloud.google.com/run/detail/cluster/us-west1-c/next/next/klogo/revisions?project=s9-demo)

#### Direct Logo Service Access 404

```shell
curl -H "Content-Type: application/json" -v \
     -d '{ "id": "logo3", "url": "https://storage.googleapis.com/kdemo-logos/google.png" }' \
     -X POST https://klogo.next.demome.tech/
```

#### Overview

* Internal microservcies (Logo and + User service for metering)
![Microservices on Cloud Run](../SVR303/img/ms-4.png "Microservices on Cloud Run")


## Reset

Reset the Cloud Run KLogo service to `External`

https://console.cloud.google.com/run/

