#!/bin/bash

# Need chmod +x ./file.sh (Should work at ansible machine)
# References: https://computingforgeeks.com/how-to-install-terraform-on-ubuntu/?expand_article=1

# Update package list
sudo apt update

# Install necessary packages
sudo apt install -y software-properties-common gnupg2 curl

# Download HashiCorp GPG key and install it
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/

# Add HashiCorp repository
sudo apt-add-repository -y "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# Install Terraform
sudo apt install -y terraform

# Install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Display Terraform version
terraform --version

# Display AWS CLI version
aws --version
