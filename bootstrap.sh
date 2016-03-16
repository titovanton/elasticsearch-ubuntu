#!/usr/bin/env bash


# hostname
hostname es-testbase
echo "127.0.0.1 es-testbase" >> /etc/hosts
echo "es-testbase" > /etc/hostname

# default
apt-get update
apt-get upgrade -y
apt-get install -y htop

# ES
apt-get install -y openjdk-7-jre-headless
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list
apt-get update
apt-get install -y elasticsearch
cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml.default
cat /etc/elasticsearch/elasticsearch.yml.default | grep ^[^#] > /etc/elasticsearch/elasticsearch.yml
echo "network.host: 10.10.10.46" >> /etc/elasticsearch/elasticsearch.yml
echo "script.inline: false" >> /etc/elasticsearch/elasticsearch.yml
echo "script.indexed: false" >> /etc/elasticsearch/elasticsearch.yml
echo "script.file: false" >> /etc/elasticsearch/elasticsearch.yml
update-rc.d elasticsearch defaults 95 10
/etc/init.d/elasticsearch start

# iptables
/vagrant/iptables.sh
echo '#!/sbin/iptables-restore' > /etc/network/if-up.d/iptables-rules
iptables-save >> /etc/network/if-up.d/iptables-rules
chmod +x /etc/network/if-up.d/iptables-rules
