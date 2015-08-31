#!/bin/sh

jack_control start
jack_control eps realtime true
jack_control eps realtime-priority 89
jack_control ds alsa
jack_control dps device hw:USB
#jack_control dps rate 96000
jack_control dps rate 48000
#jack_control dps period 512
jack_control dps period 2048
jack_control dps nperiods 3

#jack_lsp | grep -q '^intel:' ||
#	jack_load -i '-R -n 3 -p 512 -r 96000 -d hw:3' intel audioadapter

#calfjackhost eq8:equalizer ! stereo:stereo &

