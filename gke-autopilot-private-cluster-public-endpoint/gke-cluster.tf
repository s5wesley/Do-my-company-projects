resource "google_container_cluster" "gke_autopilot" {
  name     = var.cluster_name
  location = var.gcp_region1
  project  = var.gcp_project

  enable_autopilot = true

  network    = google_compute_network.vpc_network.id
  subnetwork = google_compute_subnetwork.vpc_subnet.id

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_cidr_block
  }

  release_channel {
    channel = "REGULAR"
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.authorized_networks
      content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
      }
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pod-range"
    services_secondary_range_name = "gke-service-range"
  }

  deletion_protection = false

  lifecycle {
    ignore_changes = [initial_node_count]
  }
}
