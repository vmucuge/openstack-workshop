#!/bin/bash

sudo yum install -y createrepo reposync httpd

if [ ! -d "/var/www/repo" ] ; then
  sudo mkdir -p /var/www/repo/
fi

if [ ! -d "/var/www/repo/rabbitmq" ] ; then
  sudo mkdir -p /var/www/repo/rabbitmq
fi

if [ ! -d /var/www/repo/openstack-icehouse ] ; then
  sudo mkdir -p /var/www/repo/openstack-icehouse
fi

if [ ! -f /var/www/repo/rabbitmq/rabbitmq-server-3.3.5-1.noarch.rpm ] ; then
  sudo wget -O /var/www/repo/rabbitmq/rabbitmq-server-3.3.5-1.noarch.rpm http://www.rabbitmq.com/releases/rabbitmq-server/v3.3.5/rabbitmq-server-3.3.5-1.noarch.rpm
fi

if [ ! -h "/etc/httpd/conf.d/repo.conf" ] ; then
  sudo ln -s /vagrant/files/repo.conf /etc/httpd/conf.d/
fi

sudo /sbin/service httpd status > /dev/null
HTTPD_STATUS=$?
if [ "$HTTPD_STATUS" == 3 ] ; then
  sudo /sbin/service httpd start
fi

sudo /sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
sudo echo "127.0.0.1 localhost" > /etc/hosts
sudo echo "192.168.56.33 repo.test.vm" >> /etc/hosts
sudo echo "192.168.33.33 repo.test.vm" >> /etc/hosts
sudo echo "nameserver 8.8.8.8" > /etc/resolv.conf

sudo yum update ca-certificates -y
sudo yum install yum-utils -y

if [ ! -f /vagrant/rdo-release-icehouse-4.noarch.rpm ] ; then
  wget https://repos.fedorapeople.org/repos/openstack/openstack-icehouse/rdo-release-icehouse-4.noarch.rpm -O /vagrant/rdo-release-icehouse-4.noarch.rpm
  sudo rpm -Uvh /vagrant/rdo-release-icehouse-4.noarch.rpm
else
  sudo rpm -Uvh /vagrant/rdo-release-icehouse-4.noarch.rpm
fi

sudo reposync -r openstack-icehouse -p /var/www/repo/openstack-icehouse --norepopath -n
sudo createrepo /var/www/repo/rabbitmq/
sudo createrepo /var/www/repo/openstack-icehouse/
