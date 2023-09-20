#!/bin/bash

# Enable tracing of what gets executed
set -x

# Retrieve the instance IP address from Terraform output
instance_ip=$(terraform output -raw instance_ip)

# Update the inventory.ini file with the new IP address
echo "[PyKubeDeploy]" > inventory.ini
echo "$instance_ip ansible_user=ec2-user ansible_ssh_private_key_file=/Users/robertrosario/.ssh/CastleKeys.pem" >> inventory.ini

