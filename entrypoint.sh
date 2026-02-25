#!/bin/bash
set -x

if [ "x${DISPLAY}" = "x" ];then
  sudo Xvfb :1 -screen 0 1024x768x24 &
  export DISPLAY=:1
fi

sudo iptables -t nat -D POSTROUTING -o cnem_vnic -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o cnem_vnic -j MASQUERADE
sudo sysctl -w net.ipv4.ip_forward=1

if [[ "$#" -eq 0 ]];then
  (/usr/local/SecoClient/promote/SecoClientPromoteService.sh start )&
  cd /usr/local/SecoClient/ && ./SecoClient
else
  exec "$@"
fi
