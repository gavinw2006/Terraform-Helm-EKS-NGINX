# DEPLOY HELM CHARTS LIKE NGINX AND EKS USING TERRAFORM :space_invader:

Tired of creating clusters manually just to try something out for a few minutes? Then run this. Need some apps on that cluster really fast? Use Terraforms Helm Provider on top of their kubernetes provider to quickly deploy EKS clusters with your apps on top
of them. In this example, I'm deploying NGINX via Helm provider on EKS. It takes about 15 minutes from start to finish and minimal work. 

### Pre-requisites

* Terraform installed on local workstation/laptop (or login to Terraform Cloud)
* AWS cli installed on a host to connect to the cluster
* AWS credentials configured
* kubectl installed on a host to deploy to the cluster

### Deployment Instructions
* Install Terraform or login to Terraform Cloud
* Clone this repository to your local workstation/laptop or run it via Terraform Cloud
* Run a ```terraform init``` to grab providers and modules
* Run ```aws_configure``` and establish your credentials
* Run a ```terraform_apply``` and wait 10 - 15 minutes. Note: If it fails for HTTP timeout while waiting to apply the Helm chart, retry ```terraform_apply```
* Run ```aws eks --region ap-southeast-2 update-kubeconfig --name dev-cluster``` to add the cluster context to your kubeconfig
* Run ```kubectl get pods``` and ```kubectl get svc``` to ensure NGINX deployed as expected
* Run ```kubectl get svc``` again to grab the AWS created DNS address
* Go to your browser and navigate to ```http://<dns-address>``` Note: This may take 3 - 5 minutes to resolve while waiting for NGINX to fully initialize. 


### Connecting
* Run ```aws eks --region ap-southeast-2 update-kubeconfig --name dev-cluster``` to add the context to your kubeconfig

### Troubleshooting

#### Pods stuck in Pending
* Possibility of resources not efficient. The instances in the worker group could be too small to assign IP addresses to all the pods

#### Workers not joining the cluster
* Ensure the workers are getting public IP addresses

