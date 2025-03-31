resource "google_service_account" "vm_sa" {
  account_id   = var.service_account_name
  display_name = "Service account for VM instance"
}

resource "google_project_iam_member" "vm_sa_logging" {
  project = var.gcp_project
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

resource "google_project_iam_member" "vm_sa_monitoring" {
  project = var.gcp_project
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}
