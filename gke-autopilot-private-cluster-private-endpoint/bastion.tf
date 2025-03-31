resource "google_compute_instance" "bastion" {
  name         = var.bastion_name
  machine_type = var.machine_type
  zone         = var.gcp_zone1

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork         = google_compute_subnetwork.subnet.name
    network_ip         = var.bastion_internal_ip
    access_config {}
  }

  tags = ["bastion"]

  metadata = {
    ssh-keys = "ubuntu:${file("/home/wesleymbarga/.ssh/id_rsa.pub")}"
  }
}
