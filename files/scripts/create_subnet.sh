#!/bin/bash
if [[ -z $1 && -z $2  && -z $3 ]] ; then
  echo "Usage $0 subnet_A-net_A net_A 10.10.10.0/24"
  exit 1
fi

neutron subnet-create --name $1 --dns-nameserver 8.8.8.8 $2 $3
