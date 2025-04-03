provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_cloud_run_service" "rock_band_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.container_image

        ports {
          container_port = 3000
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "5"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "noauth" {
  location = google_cloud_run_service.rock_band_service.location
  project  = var.project_id
  service  = google_cloud_run_service.rock_band_service.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
