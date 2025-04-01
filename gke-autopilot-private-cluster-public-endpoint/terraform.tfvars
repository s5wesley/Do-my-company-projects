gcp_project        = "silken-period-452805-a7"
gcp_zone1          = "us-central1-a"
gcp_region1        = "us-central1"
machine_type       = "e2-medium"
environment        = "dev"
business_divsion   = "devops"

cluster_name       = "private-autopilot-cluster"
network_name       = "gke-network"
subnet_name        = "gke-subnet"
ip_cidr_range      = "10.10.0.0/16"
master_cidr_block  = "172.16.0.0/28"
sa_name            = "gke-autopilot-sa"

pod_range          = "10.20.0.0/16"
service_range      = "10.30.0.0/20"

authorized_networks = [
  {
    cidr_block   = "0.0.0.0/0"
    display_name = "Public Access"
  }
]
