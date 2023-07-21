#!/bin/bash

# Update the permissions of the private key file
chmod 400 CastleKeys.pem

# Run Terraform to apply the infrastructure changes
terraform apply -auto-approve

# Update the inventory
./update_inventory.sh

# Wait for 150 seconds (adjust the delay as needed)
sleep 150

# Run the Ansible playbook to deploy the application
ansible-playbook -i inventory.ini deploy-app.yml -vvv
