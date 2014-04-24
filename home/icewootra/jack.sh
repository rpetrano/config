#!/bin/sh

export JACK_SAMPLE_RATE=48000
export JACK_PERIOD_SIZE=512
jackd -P89 -dalsa -dhw:USB -r$JACK_SAMPLE_RATE -p128 -n3 &
sleep 3s

alsa_in -j microphone -dhw:PCH -p $JACK_PERIOD_SIZE &
alsa_in -d cloop $JACK_SAMPLE_RATE -j alsa2jack -p $JACK_PERIOD_SIZE &
alsa_out -d ploop $JACK_SAMPLE_RATE -j jack2alsa -p $JACK_PERIOD_SIZE &
sleep 3s

jack_connect alsa2jack:capture_1 system:playback_1
jack_connect alsa2jack:capture_2 system:playback_2

jack_connect microphone:capture_1 jack2alsa:playback_1
jack_connect microphone:capture_2 jack2alsa:playback_2
