#!/bin/bash

set -ue -o pipefail

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y --no-install-recommends wget nmap htop pigz ncdu apt-transport-https
apt-get -y dist-upgrade

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list

apt-get update && sudo apt-get install elasticsearch

/usr/share/elasticsearch/bin/elasticsearch-plugin install -b discovery-gce
/usr/share/elasticsearch/bin/elasticsearch-plugin install -b repository-gcs
/usr/share/elasticsearch/bin/elasticsearch-plugin install -b analysis-icu

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
