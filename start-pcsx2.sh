#! /bin/bash

killall socat
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" 1>/dev/null 2>&1 &

open -a XQuartz

docker run \
  -e DISPLAY=192.168.99.1:0
  -v ~/.local/share/docker-pcsx2:/home/pcsx2/.config/pcsx2 \
  -it sfate/pcsx_docker
