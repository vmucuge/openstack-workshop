#!/bin/bash
if [[ -z $1 && -z $2  && -z $3 ]] ; then
  echo "Usage $0 extsubnet_A-extnet_A extnet_A 172.16.15.0/24"
  exit 1
fi

neutron subnet-create --name $1 --disable-dhcp $2 $3
