#!/usr/bin/env bash
set -e

#echo "Update all packages"
sudo yum update -y

# can be done with puppet or dns, for now statically
sudo echo "192.168.56.33 repo.test.vm" >> /etc/hosts
sudo echo "192.168.33.33 repo.test.vm" >> /etc/hosts
sudo echo "192.168.33.100 logs-splunk-01.test.vm" >> /etc/hosts

if [ ! -d /root/.ssh ] ; then
  sudo mkdir /root/.ssh
fi

sudo cp /vagrant/files/id_rsa* /root/.ssh/
sudo cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys

sudo reboot