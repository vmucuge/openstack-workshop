#!/usr/bin/env bash
set -e

#echo "Update all packages"
sudo yum update -y

#sudo yum install puppet -y
if [ ! -d /root/.ssh ] ; then
  sudo mkdir /root/.ssh
fi
sudo cp /vagrant/files/id_rsa* /root/.ssh/
sudo cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys