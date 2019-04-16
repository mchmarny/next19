# Build Solutions With Serverless on Kubernetes Engine

> Note, this demo has some project specific dependencies. When possible I identified these in comments or defined them as environment variable to allow you to easily replace them. Still, in some cases like custom domain you will have to substitute `*.next.demome.tech` for your own domain. Please open an issue if you come across any other... issue.


## Demo 1 - Cloud Build Integration

Cloud Run takes images, in this demo we will show you how to create your service image and deploy it to Cloud Run using Cloud Build

* MaxPrime (https://maxprime.next.demome.tech/)
  * Highlight release number, follow link
  * Overview the Cloud Build [configuration file](https://github.com/mchmarny/maxprime/blob/master/deployments/cloudbuild.yaml)
  * Create new release (release-v0.0.*)
* Cloud Build in console (https://console.cloud.google.com/cloud-build/builds)
  * Navigate to your GCP project
  * Detail on build, Show progress (don't watch, will take longer)
* Overview Cloud Build Integration
![Cloud Build Integration](img/cb.png "Cloud Build Integration")
* Back to browser to show new release version

The source code for [maxprime](https://github.com/mchmarny/maxprime) application is available [here](https://github.com/mchmarny/maxprime) 
