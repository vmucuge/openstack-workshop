#!/usr/bin/env bash
set -e

echo "Running into vagrant"
#sudo yum localinstall -y /vagrant/rdo-release-icehouse-4.noarch.rpm

sudo yum update -y

# PUPPET is already installed on this image
# sudo yum install puppet -y

if [ ! -d /root/.ssh ] ; then
  sudo mkdir /root/.ssh
fi

sudo cp /vagrant/files/id_rsa* /root/.ssh/
sudo chmod 600 /root/.ssh/id_rsa
sudo chmod 644 /root/.ssh/id_rsa.pub
sudo cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys

# podría hacer con puppet o dns!
sudo echo "192.168.56.33 repo.test.vm" >> /etc/hosts
sudo echo "192.168.33.33 repo.test.vm" >> /etc/hosts
sudo echo "192.168.33.100 logs-splunk-01.test.vm" >> /etc/hosts

vgs |grep cinder-volumes > /dev/null
if [ $? -ne 0 ];then
	sudo pvcreate  /dev/sdb
	sudo vgcreate cinder-volumes /dev/sdb
fi

#sudo packstack --answer-file=/vagrant/packstack_answers.txt
