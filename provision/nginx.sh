#!/usr/bin/env bash

# Install curl and  wget
apt update
apt install curl wget -y

# Install nginx
apt install nginx -y
systemctl enable nginx
systemctl start nginx

# Stop nginx service
systemctl stop nginx.service

# Remove default conf of nginx
[ -f /etc/nginx/sites-available/default ] && {
 sudo rm -fr /etc/nginx/sites-available/default
}

# Copy our nginx conf
cp /vagrant/config/nginx.conf /etc/nginx/sites-available/default

# Start nginx service
systemctl start nginx.service

# Install java
apt install openjdk-8-jdk -y

# Download and install the public key required for Elasticsearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Save the repository definition to /etc/apt/sources.list.d/elastic-6.x.list:
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list

# Install Filebeat
apt update && apt install logstash -y

# Configure Logstash
systemctl daemon-reload
systemctl enable logstash
cp /vagrant/config/logstash_nginx.conf /etc/logstash/conf.d/logstash_nginx.conf
systemctl start logstash

# Start the log collecting
cp /vagrant/config/collect-logs_nginx.service /etc/systemd/system/collect-logs_nginx.service
systemctl daemon-reload
systemctl enable collect-logs_nginx.service
systemctl start collect-logs_nginx.service
