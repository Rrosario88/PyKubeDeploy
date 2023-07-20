#!/bin/bash

terraform apply -auto-approve
./update_inventory.sh
sleep 150  # Wait for 150 seconds (adjust the delay as needed)
ansible-playbook -i inventory.ini deploy-app.yml