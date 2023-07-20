#!/bin/bash

terraform apply -auto-approve
./update_inventory.sh
sleep 120  # Wait for 60 seconds (adjust the delay as needed)
ansible-playbook -i inventory.ini deploy-app.yml