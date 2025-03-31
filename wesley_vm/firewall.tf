resource "google_compute_firewall" "allow_jenkins" {
  name    = "allow-jenkins"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = var.tags
}
