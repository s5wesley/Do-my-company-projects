resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.gcp_zone1
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.vm_image.self_link
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.subnet.name

    access_config {}
  }

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    set -e

    apt-get update -y

    # Install Java 17 (from default Debian repo)
    apt-get install -y openjdk-17-jdk

    # Add Jenkins repo and key
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee \
      /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian binary/ | tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Install Jenkins
    apt-get update -y
    apt-get install -y jenkins

    # Start Jenkins
    systemctl enable jenkins
    systemctl start jenkins

    # Wait for Jenkins to initialize and create the admin password
    echo "Waiting for Jenkins to initialize..."
    while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]; do
      sleep 5
    done

    # Output Jenkins admin password to a known file
    cat /var/lib/jenkins/secrets/initialAdminPassword > /var/tmp/jenkins-password.txt

    echo "Jenkins installed with Java 17." > /var/tmp/jenkins-installed.txt
  EOT
}

data "google_compute_image" "vm_image" {
  family  = var.image_family
  project = var.image_project
}
