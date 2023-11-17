#!/bin/bash

# ================================= Using for Ansible machine =======================================
# Install NFS server

sudo apt update
sudo apt install nfs-kernel-server

# Create folder for authenticate
sudo mkdir -p /data/mydata
sudo chown -R nobody:nogroup /data/mydata
sudo chmod -R 777 /data/mydata

sudo touch /etc/exports
 # Add line: /data/mydata *(rw, sync, no_subtree_check, insecure)
 # sudo exportfs -a
 # sudo systemctl restart nfs-kernel-server

# Turn off ufw on Ubuntu
sudo ufw disable