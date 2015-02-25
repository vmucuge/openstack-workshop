#!/bin/bash

if [[ -z $1 && -z $2 && -z $3 && -z $4 && -z $5 ]] ; then
  echo "Usage: $0 NAME ID MEM RDISK VCPUs"
  echo "Usage: $0 m1.workshop 6 128 5 1"
  exit 1
fi

nova flavor-create $1 $2 $3 $4 $5 --is-public True
# nova flavor-create m1.workshop 6 128 5 1 --is-public True
## Extra --ephemeral 1 --swap 128 --is-public True
