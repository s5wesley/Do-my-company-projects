resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  project                 = var.gcp_project
}

resource "google_compute_subnetwork" "vpc_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.gcp_region1
  network       = google_compute_network.vpc_network.id
  project       = var.gcp_project

  secondary_ip_range {
    range_name    = "gke-pod-range"
    ip_cidr_range = var.pod_range
  }

  secondary_ip_range {
    range_name    = "gke-service-range"
    ip_cidr_range = var.service_range
  }
}
