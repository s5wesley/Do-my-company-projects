output "cloud_run_url" {
  value = google_cloud_run_service.rock_band_service.status[0].url
}
