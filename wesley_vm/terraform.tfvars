gcp_project          = "silken-period-452805-a7"
gcp_region1          = "us-central1"
gcp_zone1            = "us-central1-a"
machine_type         = "e2-medium"
vm_name              = "wesley-vm"
vpc_name             = "wesley-vpc"
subnet_name          = "wesley-subnet"
subnet_ip_range      = "10.0.0.0/16"
firewall_name        = "wesley-allow-ssh"
tags                 = ["allow-ssh"]
service_account_name = "vm-service-account"
image_family         = "debian-11"
image_project        = "debian-cloud"
source_ranges        = ["75.183.218.164/32"]

