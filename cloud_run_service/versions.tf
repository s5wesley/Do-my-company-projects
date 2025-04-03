terraform {
  required_version = ">= 1.11.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket = "terraform-on-gcp-gke-avrezoe"
    prefix = "dev/rock-band"
  }
}
