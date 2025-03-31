## how to login the vm
- gcloud compute ssh wesley-vm --zone us-central1-a --project silken-period-452805-a7

## Option 1: Recreate the VM (Recommended)
This ensures the startup script runs fresh and clean.
- terraform taint google_compute_instance.vm_instance
- terraform apply -auto-approve
