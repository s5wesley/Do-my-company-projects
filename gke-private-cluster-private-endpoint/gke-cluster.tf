# Resource: GKE Cluster
resource "google_container_cluster" "gke_cluster" {
  name     = "${local.name}-gke-cluster"
  location = var.gcp_zone  # Zonal cluster

  # Node Locations: Get from Datasource: google_compute_zones
  # node_locations = data.google_compute_zones.available.names

  # Create the smallest possible default node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1


  # Network
  network    = google_compute_network.myvpc.self_link
  subnetwork = google_compute_subnetwork.mysubnet.self_link

  # In production, change it to true (Enable it to avoid accidental deletion)
  deletion_protection = false

  # Private Cluster Configurations
  private_cluster_config {
    enable_private_endpoint = true # Enable private endpoint 
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ip_range
  }

  # IP Address Ranges
  ip_allocation_policy {
    #cluster_ipv4_cidr_block  = "10.1.0.0/21"
    #services_ipv4_cidr_block = "10.2.0.0/21"
    cluster_secondary_range_name  = google_compute_subnetwork.mysubnet.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.mysubnet.secondary_ip_range[1].range_name
  }

  # Allow access to Kubernetes master API Endpoint
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.128.15.15/32"
      display_name = "Access only from Bastion VM whose IP is 10.128.15.15"
    }
  }
}
