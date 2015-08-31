#!/bin/sh

dbus_cmd() {
	exec dbus-send --session --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.$1
}

dbus_query() {
	exec dbus-send --session --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:$1
}

pid=$(pgrep -o -u "$(whoami)" spotify)
environ=/proc/$pid/environ

if [ -e "$environ" ]; then
	export $(grep -z DBUS_SESSION_BUS_ADDRESS $environ)
fi

case $1 in
	play)
		if dbus_query PlaybackStatus | not grep -q Playing; then
			dbus_cmd PlayPause
		fi
		;;
	pause)
		dbus_cmd Pause
		;;
	prev | previous)
		dbus_cmd Previous
		;;
	next)
		dbus_cmd Next
		;;
	stop)
		dbus_cmd Stop
		;;
	toggle | playpause | PlayPause | pp)
		dbus_cmd PlayPause
		;;
	*)
		echo "Usage:  $0 <action>" 1>&2
		echo -e "Actions: " 1>&2
		cat $0 | grep -A 100 case | grep -E '\)$' | grep -v '*)' | tr -d ')' 1>&2
		exit 255
esac

