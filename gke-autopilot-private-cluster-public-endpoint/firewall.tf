resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh-from-anywhere"
  network = google_compute_network.vpc_network.name
  project = var.gcp_project

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}
