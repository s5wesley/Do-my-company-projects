## command to login to the bastion-host 
- gcloud compute ssh bastion-host \
  --zone=us-central1-a \
  --project=silken-period-452805-a7
 

## To manage your private Google Kubernetes Engine (GKE) cluster from the bastion host, you'll need to install specific tools and configure access appropriately. Here's a step-by-step guide:​in your bastion host vm

1. Install Necessary Tools on the Bastion Host:
- sudo apt-get update
  sudo apt-get install google-cloud-sdk
- sudo apt-get install google-cloud-cli-gke-gcloud-auth-plugin
- gke-gcloud-auth-plugin --version

  

## Initialize the SDK:
 -  gcloud init

##  kubectl: This command-line tool enables you to run commands against Kubernetes clusters.​
- sudo apt-get install kubectl

## command to login to the gke-cluster :
 -   gcloud container clusters get-credentials private-autopilot-cluster --region=us-central1 --project=silken-period-452805-a7



