#!/bin/bash

terraform apply -auto-approve
./update_inventory.sh
ansible-playbook -i inventory.ini deploy-app.yml