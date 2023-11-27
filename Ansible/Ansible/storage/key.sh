#!/bin/bash

ip_address="$1"
key_path="/etc/letsencrypt/live/www.trourest186.online/ec2-test-key.pem"
cert_path="/etc/letsencrypt/live/www.trourest186.online/cert.pem"
privkey_path="/etc/letsencrypt/live/www.trourest186.online/privkey.pem"
des_path="/home/ubuntu/Devops-Project/Helm/django/www.trourest186.online"

sudo scp -i "$key_path" "$cert_path" "ubuntu@$ip_address:$des_path"
sudo scp -i "$key_path" "$privkey_path" "ubuntu@$ip_address:$des_path"

