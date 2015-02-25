#!/bin/bash
if [[ -z $1 ]] ; then
  echo "Usage $0 tenant_A"  
  exit 1
fi

keystone tenant-create --name $1
