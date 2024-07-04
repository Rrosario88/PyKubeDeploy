#!/bin/bash

# Set the desired Terraform version
DESIRED_VERSION="1.4.6"

# Get the current Terraform version
CURRENT_VERSION=$(terraform --version | awk '{print $2}' | sed 's/v//g')

# Function to install Terraform
install_terraform() {
    TERRAFORM_VERSION=$1
    TERRAFORM_PACKAGE="terraform_${TERRAFORM_VERSION}_darwin_arm64.zip"

    # Download the Terraform package
    echo "Downloading Terraform package..."
    curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_PACKAGE}

    # Extract the Terraform binary
    echo "Extracting Terraform binary..."
    unzip ${TERRAFORM_PACKAGE}

    # Remove the existing Terraform binary
    echo "Removing existing Terraform binary..."
    sudo rm -f /usr/local/bin/terraform

    # Move the new Terraform binary to /usr/local/bin
    echo "Moving new Terraform binary to /usr/local/bin..."
    sudo mv terraform /usr/local/bin/

    # Clean up
    echo "Cleaning up..."
    rm ${TERRAFORM_PACKAGE}
}

# Check if Terraform needs to be updated
if [ "$CURRENT_VERSION" != "$DESIRED_VERSION" ]; then
    echo "Updating Terraform from $CURRENT_VERSION to $DESIRED_VERSION"
    install_terraform $DESIRED_VERSION
else
    echo "Terraform is already up-to-date (version $CURRENT_VERSION)"
fi
