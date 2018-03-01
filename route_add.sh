#!/bin/bash

set -x

old_ips="10.244.0.0/19"
ips="10.244.0.0/16"
gw="192.168.50.4"

echo "Adding the following route entry to your local route table to enable direct container access: $ips via $gw. Your sudo password may be required." > /dev/null

if [ `uname` = "Darwin" ]; then
  sudo route delete -net $old_ips $gw
  sudo route delete -net $ips     $gw
  sudo route add    -net $ips     $gw
elif [ `uname` = "Linux" ]; then
  if type route > /dev/null 2>&1; then
    sudo route del -net $old_ips gw $gw
    sudo route add -net $ips     gw $gw
  elif type ip > /dev/null 2>&1; then
    sudo ip route del $old_ips via $gw
    sudo ip route add $ips     via $gw
  else
    echo "ERROR adding route"
    exit 1
  fi
fi
