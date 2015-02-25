#!/bin/bash
if [[ -z $1 ]] ; then
  echo "Usage $0 extnet_A"  
  exit 1
fi

neutron net-create $1 --router:external=True
