#!/bin/bash
if [[ -z $1 ]] ; then
  echo "Usage $0 net_A"  
  exit 1
fi

neutron net-create $1
