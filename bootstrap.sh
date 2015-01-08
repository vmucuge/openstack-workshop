#!/usr/bin/env bash
set -e

echo "Running into vagrant"
#sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
#sudo yum install -y https://repos.fedorapeople.org/repos/openstack/openstack-icehouse/rdo-release-icehouse-4.noarch.rpm
#echo "Update all packages"
sudo yum localinstall -y /vagrant/rdo-release-icehouse-4.noarch.rpm

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

pvs |grep cinder-volumes > /dev/null
if [ $? -ne 0 ];then
	sudo pvcreate  /dev/sdb
	sudo vgcreate cinder-volumes /dev/sdb
fi
#echo "Install Openstack with packstack answer file on /vagrant/packstack_answers.txt"
#packstack --answer-file=/vagrant/packstack_answers.txt


#echo "Installing EPEL repo"
#sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

#echo "Import Elastic Search Repo GPG Key"
#sudo rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch

packstack --answer-file=/vagrant/packstack_answers.txt
