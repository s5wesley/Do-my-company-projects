output "vm_instance_name" {
  value       = google_compute_instance.vm_instance.name
  description = "Name of the VM instance"
}

output "vm_external_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "External IP of the VM"
}

output "vm_internal_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].network_ip
  description = "Internal IP of the VM"
}

output "vpc_network_name" {
  value       = google_compute_network.vpc.name
  description = "VPC Network name"
}

output "subnet_name" {
  value       = google_compute_subnetwork.subnet.name
  description = "Subnet name"
}

output "service_account_email" {
  value       = google_service_account.vm_sa.email
  description = "Email of the VM service account"
}
