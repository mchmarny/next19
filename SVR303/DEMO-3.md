# Build Solutions With Serverless on Kubernetes Engine


## Demo 3 - Microservices (External/Internal Services)

In this demo we will show simple microservice using GCP Vision API. The source code for the applications used in this demo:

* klogo - https://github.com/mchmarny/klogo
* kuser - https://github.com/mchmarny/kuser
* kdemo - https://github.com/mchmarny/kdemo

### Logo Service

![Microservice with Vision API on Cloud Run](img/ms-1.png "Microservice with Vision API on Cloud Run")

* Image (https://storage.googleapis.com/kdemo-logos/k8s.png)
* Image service ("Google" logo identified)

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "logo1", "url": "https://storage.googleapis.com/kdemo-logos/k8s.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

### Authentication App

![Auth microservice fronting Logo Service](img/ms-2.png "Auth Microservice fronting Logo Service")
* Demo UI (https://kdemo.next.demome.tech/)


### Circumvent Auth

![Auth Microservice fronting Logo Service](img/ms-3.png "Auth Microservice fronting Logo Service")

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "logo2", "url": "https://storage.googleapis.com/kdemo-logos/k8s.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

### Logo Service (Internal)

* Cloud Run (https://console.cloud.google.com/run/detail/cluster/us-west1-c/next/next/klogo/revisions?project=s9-demo)
  * Connectivity in Details to `Internal`

### Direct Logo Service Access 404

```shell
curl -H "Content-Type: application/json" -v \
     -d '{ "id": "logo3", "url": "https://storage.googleapis.com/kdemo-logos/k8s.png" }' \
     -X POST https://klogo.next.demome.tech/
```

### Overview

* Internal microservices (Logo and User for metering)
![Microservices on Cloud Run](img/ms-4.png "Microservices on Cloud Run")


