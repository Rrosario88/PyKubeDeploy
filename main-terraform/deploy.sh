#!/bin/bash

# Update the permissions of the private key file
chmod 400 /Users/robertrosario/.ssh/CastleKeys.pem

# Run Terraform to apply the infrastructure changes
terraform apply -auto-approve

# Update the inventory
./update_inventory.sh

# Wait for 60 seconds (adjust the delay as needed)
sleep 60

# Disable strict host key checking
export ANSIBLE_HOST_KEY_CHECKING=False

# Run the Ansible playbook to deploy the application
ansible-playbook -i inventory.ini ../app/deploy-app.yml --private-key=/Users/robertrosario/.ssh/CastleKeys.pem -vvvv