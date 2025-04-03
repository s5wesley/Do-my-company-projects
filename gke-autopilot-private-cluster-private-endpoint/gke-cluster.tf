resource "google_container_cluster" "autopilot_cluster" {
  name     = var.cluster_name
  location = var.gcp_region1

  enable_autopilot = true
  network          = google_compute_network.vpc_network.id
  subnetwork       = google_compute_subnetwork.subnet.id

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = var.master_cidr_block
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${var.bastion_internal_ip}/32"
      display_name = "Bastion Host"
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  deletion_protection = false

  depends_on = [google_service_account.gke_sa]
}
