#!/bin/bash

# ================================= Using for Jenkins machine =======================================
sudo apt-get update

# Install Java
sudo apt install openjdk-11-jdk
java --version

# Add repo for Jenkins
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]  https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update

# Install 
sudo apt install jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

# Turn off ufw on Ubuntu
sudo ufw disable

# Install Helm
curl -sSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install Nginx to setup Nginx layer 7
sudo apt install nginx 