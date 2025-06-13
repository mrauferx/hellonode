# hellonode
This is a very basic Hello World application written with Node.

It includes a `Dockerfile` for building a Docker image with the application, and a `Jenkinsfile` that defines a build pipeline for it.
The pipeline will check out and scan the code using Aqua. 

If the scan passes muster, the pipeline will continue to build the image, then scan it for vulnerabilities and configuration conformance using either Aqua, NeuVector, or Prisma Cloud.

If the image passes the scan it will be pushed to a local Harbor registry and then deployed to a local Kubernetes cluster using Helm.
The Dockerfile controls the base image to build from; change as needed to illustrate difference in vulnerability findings after scanning.
Note: uninstall Helm chart before next deployment.

The scenario has been extended to use GitHub Actions as the pipeline to build, scan, and deploy the application to GAR and GKE.

Access to Aqua SaaS, Prisma Cloud SaaS, GCP project with GAR and GKE, or a deployment of NeuVector is required. Alternatively, trivy open source can be used for code and image scanning.
Credentials for Git, security tools, cluster, and registry must be defined in Jenkins or GitHub.
Jenkins needs to run locally to the registry. Alternatively, change to push to a remote registry such as quay.io.
