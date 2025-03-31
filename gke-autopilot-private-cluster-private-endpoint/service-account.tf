resource "google_service_account" "gke_sa" {
  account_id   = var.sa_name
  display_name = "GKE Autopilot SA"
}
