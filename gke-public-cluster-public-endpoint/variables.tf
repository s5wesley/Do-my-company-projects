# GCP Project
variable "gcp_project" {
  description = "Project in which GCP Resources will be created"
  type        = string
}

# GCP Region (used for regional resources like subnets)
variable "gcp_region1" {
  description = "Region in which GCP regional resources will be created (e.g., us-central1)"
  type        = string
}

# GCP Zone (used for zonal resources like GKE cluster and node pool)
variable "gcp_zone1" {
  description = "Zone in which GKE cluster and node pool will be created (e.g., us-central1-a)"
  type        = string
}

# GCP Compute Engine Machine Type
variable "machine_type" {
  description = "Compute Engine Machine Type for GKE nodes"
  type        = string
}

# Environment (e.g., dev, prod)
variable "environment" {
  description = "Environment prefix (e.g., dev, staging, prod)"
  type        = string
}

# Business Division (tag or prefix for team ownership)
variable "business_divsion" {
  description = "Business Division within the organization this infrastructure belongs to"
  type        = string
}

# Node Pool Size
variable "node_pool_1_count" {
  description = "Number of nodes in node pool 1"
  type        = number
}
