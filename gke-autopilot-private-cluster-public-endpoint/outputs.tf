output "cluster_name" {
  value = google_container_cluster.gke_autopilot.name
}

output "endpoint" {
  value = google_container_cluster.gke_autopilot.endpoint
}

output "master_authorized_networks" {
  value = google_container_cluster.gke_autopilot.master_authorized_networks_config
}

output "service_account_email" {
  value = google_service_account.gke_sa.email
}
