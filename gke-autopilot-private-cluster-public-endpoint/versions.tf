terraform {
  required_version = ">= 1.10.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-on-gcp-gke-avrezoe"
    prefix = "dev/gke-autopilot-private-public-endpoint"
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region1
}
