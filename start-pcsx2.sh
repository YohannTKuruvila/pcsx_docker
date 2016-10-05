#!/bin/bash
trap cleanup INT

IMAGE_NAME='sfate/pcsx_docker'

SOCAT_PID_FILE=tmp/socat.pid
XQUARTZ_PID_FILE=tmp/xquartz.pid

LOCAL_IP=$(ipconfig getifaddr en0)
if [ -z $LOCAL_IP ]; then
  LOCAL_IP=$(ipconfig getifaddr en4)
fi

cleanup() {
  docker rm -f $(docker ps -a |grep $IMAGE_NAME|awk '{print $1}')
  kill $(cat $SOCAT_PID_FILE)
  kill $(cat $XQUARTZ_PID_FILE)
  rm tmp/*
}

if [ ! -d tmp ]; then
  mkdir tmp
fi

if [ -f $SOCAT_PID_FILE ]; then
  kill $(cat $SOCAT_PID_FILE)
fi
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" 1>/dev/null 2>&1 &
echo $! > $SOCAT_PID_FILE

if [ -f $XQUARTZ_PID_FILE ]; then
  kill $(cat $XQUARTZ_PID_FILE)
fi
exec /Applications/Utilities/XQuartz.app/Contents/MacOS/X11.bin 1>/dev/null 2>&1 &
echo $! > $XQUARTZ_PID_FILE

if [ -z "$(docker images -a | grep $IMAGE_NAME)" ]; then
  docker build -t $IMAGE_NAME .
fi

xhost + $LOCAL_IP
docker run \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=$LOCAL_IP:0 \
  -v ~/.local/share/docker-pcsx2:/home/pcsx2/.config/pcsx2 \
  -it $IMAGE_NAME

cleanup

exit 0
