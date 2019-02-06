#!/usr/bin/env bash


# Update apt db
apt update

# Install wget
apt install wget curl -y

# Install java
apt install openjdk-8-jdk -y

# Download and install the public key required for Elasticsearch
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Install the apt-transport-https package on Debian before proceeding
#apt install apt-transport-https -y

# Save the repository definition to /etc/apt/sources.list.d/elastic-6.x.list:
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list

# Install Elasticsearch
apt update && apt install elasticsearch -y

# Reload services
systemctl daemon-reload

# Enable elasticsearch service
systemctl enable elasticsearch

# Start elasticsearch service
systemctl start elasticsearch

# Copy edited elasticsearch yaml file
cp /vagrant/config/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

# Restart elasticsearch
systemctl restart elasticsearch

sleep 10

# Install Kibana
apt install kibana -y

# Start service
cp /vagrant/config/kibana.yml /etc/kibana/kibana.yml
systemctl daemon-reload
systemctl enable kibana
systemctl start kibana

# Install Filebeat
apt install filebeat -y

# Configure Filebeat
systemctl daemon-reload
systemctl enable filebeat
filebeat modules enable system
cp /vagrant/config/filebeat.yml /etc/filebeat/filebeat.yml
cp /vagrant/config/system.yml.disabled /etc/filebeat/modules.d/system.yml
systemctl start filebeat

# Install geoip plugin for Elasticsearch
sudo /usr/share/elasticsearch/bin/elasticsearch-plugin install --batch ingest-geoip
sudo systemctl restart elasticsearch
sudo systemctl restart filebeat
