resource "google_compute_project_metadata" "enable_os_login" {
  project = var.gcp_project

  metadata = {
    enable-oslogin = "TRUE"
  }
}
