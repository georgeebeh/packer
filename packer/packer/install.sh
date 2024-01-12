#!/bin/bash
sudo apt-get update  
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
echo 'y' | sudo ufw enable