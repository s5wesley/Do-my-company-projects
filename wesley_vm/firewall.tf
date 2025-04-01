resource "google_compute_firewall" "allow_jenkins" {
  name    = var.firewall_name
  network = google_compute_network.vpc.name

  description = "Allow SSH and Jenkins (TCP ports 22 and 8080) from trusted IP"

  allow {
    protocol = "tcp"
    ports    = ["22", "8080"]
  }

  source_ranges = ["75.183.218.164/32"]
  target_tags   = var.tags
}
