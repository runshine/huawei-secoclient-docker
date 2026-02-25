#!/bin/bash
set -e

if [ "x${DISPLAY}" = "x" ];then
  Xvfb :1 -screen 0 1024x768x24 &
  export DISPLAY=:1
fi

if [[ "$#" -eq 0 ]];then
  (/usr/local/SecoClient/promote/SecoClientPromoteService.sh start )&
  cd /usr/local/SecoClient/ && ./SecoClient
else
  exec "$@"
fi
