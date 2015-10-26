#!/bin/bash

kill $(cat socat.pid)
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" 1>/dev/null 2>&1 &
echo $! > socat.pid

kill $(cat xquartz.pid)
exec /Applications/Utilities/XQuartz.app/Contents/MacOS/X11.bin 1>/dev/null 2>&1 &
echo $! > xquartz.pid

docker run \
  -e DISPLAY=192.168.99.1:0 \
  -v ~/.local/share/docker-pcsx2:/home/pcsx2/.config/pcsx2 \
  -it sfate/pcsx_docker

kill $(cat socat.pid)
kill $(cat xquartz.pid)

exit 0
