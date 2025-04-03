## how to login the vm
- gcloud compute ssh wesley-vm --zone us-central1-a --project silken-period-452805-a7

## Option 1: Recreate the VM (Recommended)
This ensures the startup script runs fresh and clean.
- terraform taint google_compute_instance.vm_instance
- terraform apply -auto-approve

## command to get the jenkins password
- cat /var/tmp/jenkins-password.txt
## need to change this ip address and put your local machine ip address 
  -source_ranges = ["75.183.218.164/32"] -this is mac ip.. run this command to get your local ip address - curl -4 ifconfig.me

