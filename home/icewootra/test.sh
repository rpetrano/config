#!/bin/bash

gst-launch-1.0 ximagesrc! video/x-raw, framerate=60/1, width=1920, height=1080 ! xvimagesink
