# Input Variables
# GCP Project
variable "gcp_project" {
  description = "Project in which GCP Resources to be created"
  type        = string
}

# GCP Region
variable "gcp_region1" {
  description = "Region in which GCP Resources to be created"
  type        = string
}

# GCP Compute Engine Machine Type
variable "machine_type" {
  description = "Compute Engine Machine Type"
  type        = string
}


# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type        = string
}

# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type        = string
}

# CIDR IP Ranges
variable "subnet_ip_range" {
  description = "Subnet IP range"
  type        = string
}

variable "pods_ip_range" {
  description = "Kubernetes Pods IP range"
  type        = string
}

variable "services_ip_range" {
  description = "Kubernetes Services IP range"
  type        = string
}

variable "master_ip_range" {
  description = "Kubernetes Master IP range"
  type        = string
}

variable "gcp_zone" {
  description = "GCP zone for the GKE cluster (e.g., us-central1-a)"
  type        = string
}
