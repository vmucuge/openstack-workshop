#!/bin/bash
if [[ -z $1 && -z $2 && -z $3 && -z $4 ]] ; then
  echo "Usage $0 user_A password_A tenant_A user_A@workshop.com"  
  exit 1
fi

keystone user-create --name $1 --pass $2 --tenant $3 --email $4
