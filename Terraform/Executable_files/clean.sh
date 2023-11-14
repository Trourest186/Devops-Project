#!/bin/bash

# Destroy Resources
terraform destroy -auto-approve

# Clean-Up 
rm -rf .terraform*
rm -rf terraform.tfstate*