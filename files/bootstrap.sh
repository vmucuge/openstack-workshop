#!/usr/bin/env bash
set -e
echo "Update all packages"
sudo /usr/bin/yum clean all
sudo /usr/bin/yum update -y

echo "Install Epel and RDO Relase Icehouse Repos"
if [ $(rpm -qa|grep -c epel-release-6-8.noarch) -gt 0 ]; then
  echo "Package epel-release-6-8.noarch is installed, skipping."
 else
  sudo /bin/rpm -Uvh /vagrant/files/epel-release-6-8.noarch.rpm
fi
#
if [ $(rpm -qa|grep -c rdo-release-icehouse-4.noarch) -gt 0 ]; then
  echo "Package rdo-release-icehouse-4.noarch is installed, skipping."
 else
  sudo /bin/rpm -Uvh /vagrant/files/rdo-release-icehouse-4.noarch.rpm
fi

#echo "Install Openstack with packstack answer file on /vagrant/packstack-vagrant.txt"
#sudo packstack --answer-file=/vagrant/files/packstack-vagrant.txt
echo "Once you have the nodes ready, execute from the rdonode01, as root user:"
echo "# packstack --answer-file=/vagrant/files/packstack-vagrant.txt"
