# Resource: GKE Node Pool 1
resource "google_container_node_pool" "nodepool_1" {
  name       = "${local.name}-node-pool-1"
  location   = var.gcp_zone1  # Changed from var.gcp_region1 to var.gcp_zone1
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.node_pool_1_count

  node_config {
    preemptible    = true
    machine_type   = var.machine_type
    disk_type      = "pd-standard"
    disk_size_gb   = 50

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.gke_sa.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    tags = [tolist(google_compute_firewall.fw_ssh.target_tags)[0]]
  }
}
