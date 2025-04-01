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

variable "subnet_ip_range" {
  description = "CIDR range for the subnet"
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
}

variable "image_project" {
  description = "Image project"
  type        = string
}

variable "service_account_name" {
  description = "Name of the custom service account"
  type        = string
}
