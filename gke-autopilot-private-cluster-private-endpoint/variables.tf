variable "gcp_project" {
  description = "The GCP project ID"
  type        = string
}

variable "gcp_region1" {
  description = "The GCP region"
  type        = string
}

variable "gcp_zone1" {
  description = "The GCP zone"
  type        = string
}

variable "machine_type" {
  description = "Machine type for Bastion and default nodes"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
}

variable "network_name" {
  description = "VPC network name"
  type        = string
}

variable "subnet_name" {
  description = "Subnetwork name"
  type        = string
}

variable "ip_cidr_range" {
  description = "CIDR range for the subnetwork"
  type        = string
}

variable "master_cidr_block" {
  description = "CIDR block for GKE master authorized range"
  type        = string
}

variable "sa_name" {
  description = "Service account name"
  type        = string
}

variable "bastion_name" {
  description = "Name of the Bastion Host instance"
  type        = string
  default     = "bastion-host"
}

variable "bastion_internal_ip" {
  description = "Internal IP of the Bastion Host"
  type        = string
}

variable "pods_secondary_range_name" {
  description = "Secondary range name for GKE Pods"
  type        = string
}

variable "pods_secondary_range_cidr" {
  description = "CIDR block for GKE Pods secondary range"
  type        = string
}

variable "services_secondary_range_name" {
  description = "Secondary range name for GKE Services"
  type        = string
}

variable "services_secondary_range_cidr" {
  description = "CIDR block for GKE Services secondary range"
  type        = string
}

variable "business_division" {
  description = "Business division tag"
  type        = string
}
