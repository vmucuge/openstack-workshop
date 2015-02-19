- Install Vagrant

DEBIAN/UBUNTU: https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb

WIN: https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2.msi

CENTOS/RH/FEDORA: https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.rpm

- Adjust memory for the instances, where

vb.customize ["modifyvm", :id, "--memory", "2048", "--name", "#{vm_name}"]

Use: 768/1024 for each VM

- Change cinder_volume.vdi path, used for rdonode01 node

cinder_volume = "/tmp/cinder_volume.vdi"


- Spin up the VMs

$ vagrant up rdonode02

$ vagrant up rdonode01

- Restart VMs (after upgrade)

$ vagrant reload

- SSH to rdonode01

$ vagrant ssh rdonode01

- Run commands

$ sudo -i

 # packstack --answer-file=/vagrant/files/packstack-vagrant.txt

!! Good Luck, if you finally see something like this:

Applying Puppet manifests                            [ DONE ]
Finalizing                                           [ DONE ]

 **** Installation completed successfully ******


Additional information:
 * Did not create a cinder volume group, one already existed
 * File /root/keystonerc_admin has been created on OpenStack client host 192.168.33.20. To use the command line tools you need to source the file.
 * To access the OpenStack Dashboard browse to http://192.168.33.20/dashboard .
Please, find your login credentials stored in the keystonerc_admin in your home directory.
 * To use Nagios, browse to http://192.168.33.20/nagios username: nagiosadmin, password: nagiosadmin
 * The installation log file is available at: /var/tmp/packstack/20150219-143731-0qDrKf/openstack-setup.log
 * The generated manifests are available at: /var/tmp/packstack/20150219-143731-0qDrKf/manifests


Then start to play but take care, things will start to break!!

@ : viniciusmucuge@gmail.com