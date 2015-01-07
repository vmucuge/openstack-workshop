#!/usr/bin/env bash
set -e

echo "Running into vagrant"
sudo yum localinstall -y /vagrant/rdo-release-icehouse-4.noarch.rpm

sudo yum update -y

# PUPPET is already installed on this image
# sudo yum install puppet -y

if [ ! -d /root/.ssh ] ; then
  sudo mkdir /root/.ssh
fi

sudo cp /vagrant/files/id_rsa* /root/.ssh/
sudo cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys

sudo pvcreate /dev/sdb
sudo vgcreate cinder-volumes /dev/sdb

packstack --answer-file=/vagrant/packstack_answers.txt
