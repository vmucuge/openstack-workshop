#!/bin/bash

if [ ! $#  = 1 ] ; then
  echo "Usage: $0 import|unzip"
fi



unzip_img ()
{
  cd /vagrant
  if [ ! -f coreos_production_openstack_image.img ] ; then
    bunzip2 coreos_production_openstack_image.img.bz2
  fi
}

import_img ()
{
  if [ -f /vagrant/coreos_production_openstack_image.img ] ; then
    glance image-create --name CoreOS \
      --container-format bare \
      --disk-format qcow2 \
      --file /vagrant/coreos_production_openstack_image.img \
      --is-public True
    else
      unzip_img
      import_img
  fi
}

case $1 in
  import)
    import_img 
    ;;
  unzip)
    unzip_img 
    ;;
esac

