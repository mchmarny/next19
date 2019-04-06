# HYB218 - Run a serverless platform anywhere with Kubernetes and Knative

> Make sure to [reset](#Reset) environment before demos

## Demo - Microservices (External/Internal Services)

In this demo we will show simple microservice using GCP Vision API

![Microservice with Vision API on Cloud Run](../SVR303/img/ms-1.png "Microservice with Vision API on Cloud Run")

* Demo service
  * Show image (https://storage.googleapis.com/kdemo-logos/0.png)
  * Run image through service and show "Google" identified

```shell
curl -H "Content-Type: application/json" \
     -d '{ "id": "next-demo", "url": "https://storage.googleapis.com/kdemo-logos/0.png" }' \
     -X POST https://klogo.next.demome.tech/ | jq "."
```

* Illustrate problem statement (credits)
  * Fronting UI App to Auth
![Auth Microservice fronting Logo Service](img/ms-2.png "Auth Microservice fronting Logo Service")
  * Show UI (https://kdemo.next.demome.tech/)
  * Users still can circumvent Auth by direct Logo service access
![Auth Microservice fronting Logo Service](img/ms-3.png "Auth Microservice fronting Logo Service")

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

* Show final overview of internal services (+ User Microservice to metering) and external UI

![Microservices on Cloud Run](img/ms-4.png "Microservices on Cloud Run")


## Reset

Reset the Cloud Run KLogo service to `External`

https://console.cloud.google.com/run/detail/cluster/us-west1-c/next/next/klogo/general?project=s9-demo

