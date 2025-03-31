terraform {
  required_version = ">= 1.10.3"

  backend "gcs" {
    bucket = "terraform-on-gcp-gke-avrezoe"
    prefix = "dev/wesley_vm"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region1
  zone    = var.gcp_zone1
}
