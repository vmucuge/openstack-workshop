#!/usr/bin/env bash
set -x

echo "Running into vagrant"
# sudo yum localinstall -y /vagrant/rdo-release-icehouse-4.noarch.rpm

yum update -y

if [ ! -d /root/.ssh ] ; then
  mkdir -p /root/.ssh
fi

sudo cp /vagrant/files/id_rsa* /root/.ssh/
sudo chmod 600 /root/.ssh/id_rsa
sudo chmod 644 /root/.ssh/id_rsa.pub
#sudo chmod 777 /root/.ssh/
sudo cp /vagrant/files/authorized_keys /root/.ssh/authorized_keys
sudo chmod 750 /root/.ssh/

vgs | grep cinder-volumes > /dev/null
if [ $? -ne 0 ] ; then
  pvcreate  /dev/sdb
  vgcreate cinder-volumes /dev/sdb
fi

packstack --answer-file=/vagrant/packstack_answers.txt
