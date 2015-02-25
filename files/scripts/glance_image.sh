#!/bin/bash
if [[ -z $1 && -z $2 ]] ; then
  echo "Usage $0 Cirros3-x86_64 http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img"
  exit 1
fi

glance image-create --name $1 --copy-from $2 --is-public true --container-format bare --disk-format raw
