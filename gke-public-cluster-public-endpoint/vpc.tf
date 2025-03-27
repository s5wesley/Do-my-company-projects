# Resource: VPC
resource "google_compute_network" "myvpc" {
  name                    = "${local.name}-vpc"
  auto_create_subnetworks = false
}

# Resource: Subnet (regional subnet remains in the region)
resource "google_compute_subnetwork" "mysubnet" {
  name                     = "${local.name}-us-central1-subnet"  # Explicit regional name
  region                   = var.gcp_region1                        # Hardcoded since subnet must be regional
  ip_cidr_range            = "10.128.0.0/20"
  network                  = google_compute_network.myvpc.id
  private_ip_google_access = true
}
