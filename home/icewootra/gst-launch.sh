#!/bin/bash

print-args() {
	for i in "$@"; do
		echo "[$i]"
	done
	"$@"
}

pipeline=(
flvmux name=mux streamable=true ! filesink max-lateness=1000000 blocksize=2000000 buffer-size=20000000 location=test.flv
  ximagesrc ! queue ! video/x-raw,framerate=30/1 ! videoconvert ! video/x-raw,format=I420 ! x264enc bitrate=3300 key-int-max=60 speed-preset=medium ! queue ! mux.
  jackaudiosrc blocksize=2000000 client-name=twitch connect=none ! queue ! audioconvert ! audio/x-raw,rate=96000,channels=2 ! faac bitrate=192000 ! queue ! mux.)

exec gst-launch-1.0 -v "${pipeline[@]}"
