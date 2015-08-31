gst-launch-1.0 ximagesrc use-damage=0 ! video/x-raw,framerate=15/1 ! videoconvert ! x264enc bitrate=3300 ! flvmux ! filesink location=test.flv
gst-launch-1.0 jackaudiosrc client-name=twitch ! audioconvert ! audio/x-raw,rate=96000,channels=2 ! faac bitrate=192000 ! flvmux ! filesink location=test.ac2
