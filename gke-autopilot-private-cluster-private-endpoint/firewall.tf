# Firewall rule to allow SSH from your local machine to the Bastion Host
resource "google_compute_firewall" "allow_ssh_to_bastion" {
  name    = "allow-ssh-to-bastion"
  network = google_compute_network.vpc_network.name

  direction     = "INGRESS"
  source_ranges = [var.bastion_ssh_source_ip] # Your public IP in CIDR format
  target_tags   = ["bastion"]                 # Ensure this tag is on your Bastion Host

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Firewall rule to allow Bastion Host to connect to GKE Control Plane (Ingress on control plane side)
resource "google_compute_firewall" "allow_bastion_to_gke_control_plane" {
  name    = "allow-bastion-to-gke-control-plane"
  network = google_compute_network.vpc_network.name

  direction     = "INGRESS"
  source_ranges = ["10.10.0.10/32"]     # Bastion's internal IP
  target_tags   = ["gke-control-plane"] # Ensure this tag is set on GKE nodes or routes

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

# Egress rule to allow Bastion Host to reach GKE control plane's public IP
resource "google_compute_firewall" "egress_bastion_to_gke" {
  name    = "egress-bastion-to-gke"
  network = google_compute_network.vpc_network.name

  direction          = "EGRESS"
  priority           = 1000
  destination_ranges = ["172.16.0.2/32"] # GKE control plane public IP
  target_tags        = ["bastion"]       # Bastion host tag

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}
