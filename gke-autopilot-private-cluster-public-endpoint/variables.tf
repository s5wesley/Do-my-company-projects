variable "gcp_project" {
  type        = string
  description = "GCP project ID"
}

variable "gcp_region1" {
  type        = string
  description = "Region for regional resources"
}

variable "gcp_zone1" {
  type        = string
  description = "Zone for zonal resources like node pools"
}

variable "machine_type" {
  type        = string
  description = "Machine type for node pools (not needed for Autopilot, but keeping for metadata)"
}

variable "environment" {
  type        = string
  description = "Environment label (e.g., dev, prod)"
}

variable "business_divsion" {
  type        = string
  description = "Business division for labeling"
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}

variable "network_name" {
  type        = string
  description = "Name of the VPC network"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "ip_cidr_range" {
  type        = string
  description = "CIDR range for subnet"
}

variable "master_cidr_block" {
  type        = string
  description = "CIDR block for GKE control plane"
}

variable "sa_name" {
  type        = string
  description = "Name of the GKE service account"
}

variable "authorized_networks" {
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  description = "List of authorized CIDR blocks for public endpoint"
}

variable "pod_range" {
  type        = string
  description = "Secondary IP range for GKE pods"
}

variable "service_range" {
  type        = string
  description = "Secondary IP range for GKE services"
}
