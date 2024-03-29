# Run a serverless platform anywhere with Kubernetes and Knative

> Note, this demo has some project specific dependencies. When possible I identified these in comments or defined them as environment variable to allow you to easily replace them. Still, in some cases like custom domain you will have to substitute `*.next.demome.tech` for your own domain. Please open an issue if you come across any other... issue.

## Demo - Microservices (External/Internal Services)

In this demo we will show simple microservice using GCP Vision API. The source code for the applications used in this demo:

* klogo - https://github.com/mchmarny/klogo
* kuser - https://github.com/mchmarny/kuser
* kdemo - https://github.com/mchmarny/kdemo

### Logo Service

Deploy service usign gcloud

```shell
gcloud beta run deploy klogo \
    --image=gcr.io/knative-samples/klogo:latest \
    --set-env-vars=RELEASE=v0.0.3,GIN_MODE=release
```

![Microservice with Vision API on Cloud Run](../SVR303/img/ms-1.png "Microservice with Vision API on Cloud Run")

Run image (https://storage.googleapis.com/kdemo-logos/google.png)

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "logo1", "url": "https://storage.googleapis.com/kdemo-logos/google.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

### Authentication App

```shell
gcloud beta run deploy kdemo \
    --image=gcr.io/knative-samples/kdemo \
    --set-env-vars=RELEASE=v0.0.5,FORCE_HTTPS=yes,OAUTH_CLIENT_ID=$DEMO_OAUTH_CLIENT_ID,OAUTH_CLIENT_SECRET=$DEMO_OAUTH_CLIENT_SECRET,GCP_PROJECT_ID=$GCP_PROJECT,KLOGO_SERVICE_URL=http://klogo.next.svc.cluster.local,KUSER_SERVICE_URL=http://kuser.next.svc.cluster.local
```

![Auth Microservice fronting Logo Service](../SVR303/img/ms-2.png "Auth Microservice fronting Logo Service")
* Demo UI (https://kdemo.next.demome.tech/)


### Circumvent Authentication App

![Auth Microservice fronting Logo Service](../SVR303/img/ms-3.png "Auth Microservice fronting Logo Service")

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "logo2", "url": "https://storage.googleapis.com/kdemo-logos/google.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

### Set Logo Service as "Internal"

Set connectivity in details to `Internal` in Cloud Run (https://console.cloud.google.com/run/detail/cluster/us-west1-c/next/next/klogo/revisions?project=s9-demo)

### Direct Logo Service Access 404

```shell
curl -H "Content-Type: application/json" -v \
     -d '{ "id": "logo3", "url": "https://storage.googleapis.com/kdemo-logos/google.png" }' \
     -X POST https://klogo.next.demome.tech/
```

### Overview

* Internal microservcies (Logo and + User service for metering)
![Microservices on Cloud Run](../SVR303/img/ms-4.png "Microservices on Cloud Run")


## Reset

Reset the Cloud Run KLogo service to `External`

https://console.cloud.google.com/run/

