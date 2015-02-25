#!/bin/bash
if [[ -z $1 && -z $2 ]] ; then
  echo "Usage $0 extrouter_A net_A"  
  exit 1
fi

neutron router-gateway-set $1 $2
