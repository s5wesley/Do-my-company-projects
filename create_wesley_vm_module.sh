#!/bin/bash

# Create main directory
mkdir -p wesley_vm && cd wesley_vm

# Create and write versions.tf
cat > versions.tf <<EOF
terraform {
  required_version = ">= 1.4.0"

  backend "gcs" {
    bucket = "terraform-on-gcp-gke-avrezoe"
    prefix = "dev/gke-autopilot-private-private-endpoint"
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
EOF

# Create and write variables.tf
cat > variables.tf <<EOF
variable "gcp_project" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_region1" {
  description = "GCP region"
  type        = string
}

variable "gcp_zone1" {
  description = "GCP zone"
  type        = string
}

variable "machine_type" {
  description = "GCE machine type"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "firewall_name" {
  description = "Name of the firewall rule"
  type        = string
}

variable "tags" {
  description = "Network tags"
  type        = list(string)
}

variable "image_family" {
  description = "Image family for the boot disk"
  type        = string
  default     = "debian-11"
}

variable "image_project" {
  description = "Image project"
  type        = string
  default     = "debian-cloud"
}

variable "service_account_name" {
  description = "Name of the custom service account"
  type        = string
  default     = "vm-service-account"
}
EOF

# Create and write terraform.tfvars
cat > terraform.tfvars <<EOF
gcp_project          = "silken-period-452805-a7"
gcp_region1          = "us-central1"
gcp_zone1            = "us-central1-a"
machine_type         = "e2-medium"
vm_name              = "example-vm"
vpc_name             = "vm-vpc"
subnet_name          = "vm-subnet"
firewall_name        = "allow-ssh"
tags                 = ["allow-ssh"]
service_account_name = "vm-service-account"
EOF

# Create and write vpc.tf
cat > vpc.tf <<EOF
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = "10.0.0.0/24"
  region        = var.gcp_region1
  network       = google_compute_network.vpc.id
}
EOF

# Create and write firewall.tf
cat > firewall.tf <<EOF
resource "google_compute_firewall" "allow_ssh" {
  name    = var.firewall_name
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.tags
}
EOF

# Create and write service-account.tf
cat > service-account.tf <<EOF
resource "google_service_account" "vm_sa" {
  account_id   = var.service_account_name
  display_name = "Service account for VM instance"
}

resource "google_project_iam_member" "vm_sa_logging" {
  project = var.gcp_project
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:\${google_service_account.vm_sa.email}"
}

resource "google_project_iam_member" "vm_sa_monitoring" {
  project = var.gcp_project
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:\${google_service_account.vm_sa.email}"
}
EOF

# Create and write vm.tf
cat > vm.tf <<EOF
resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.gcp_zone1
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.vm_image.self_link
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name

    access_config {}
  }

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "Provisioned by Terraform with service account" > /var/tmp/terraform.txt
  EOT
}

data "google_compute_image" "vm_image" {
  family  = var.image_family
  project = var.image_project
}
EOF

# Create and write outputs.tf
cat > outputs.tf <<EOF
output "vm_instance_name" {
  value       = google_compute_instance.vm_instance.name
  description = "Name of the VM instance"
}

output "vm_external_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "External IP of the VM"
}

output "vm_internal_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
  description = "Internal IP of the VM"
}

output "vpc_network_name" {
  value       = google_compute_network.vpc.name
  description = "VPC Network name"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "Subnet name"
}

output "service_account_email" {
  value       = google_service_account.vm_sa.email
  description = "Email of the VM service account"
}
EOF

echo "✅ Terraform module created in ./wesley_vm"

