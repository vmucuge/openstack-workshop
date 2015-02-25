#!/bin/bash
if [[ -z $1 ]] ; then
  echo "Usage $0 extrouter_A"  
  exit 1
fi

neutron router-create $1
