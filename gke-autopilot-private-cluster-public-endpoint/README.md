# GKE Autopilot Private Cluster with Public Endpoint

This Terraform module creates a **GKE Autopilot Private Cluster** on Google Cloud with a **public control plane endpoint**, using a custom VPC, subnetwork, service account, and firewall rules. The module is designed to be easily reusable and environment-aware.

---

## 📁 Directory Structure

gke-autopilot-private-cluster-public-endpoint/ ├── firewall.tf ├── gke-cluster.tf ├── local-values.tf ├── outputs.tf ├── service-account.tf ├── terraform.tfvars ├── variables.tf ├── versions.tf └── vpc.tf


---

## 🚀 Prerequisites

- Terraform v1.10.3 or later
- Google Cloud SDK installed and authenticated
- A GCS bucket set up for Terraform backend
- Billing enabled for your GCP project

---

## 🔧 Setup Instructions

### 1. Clone or Generate the Files

Run the `create_gke_cluster_files.sh` script to automatically create all `.tf` files in the correct structure.

```bash
chmod +x create_gke_cluster_files.sh
./create_gke_cluster_files.sh


##  Step-by-Step Login Command
gcloud container clusters get-credentials private-autopilot-cluster \
  --region us-central1 \
  --project silken-period-452805-a7
