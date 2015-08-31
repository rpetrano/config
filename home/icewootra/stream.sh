#!/bin/sh

STREAM_KEY="$(gpg -d ~/.passwd/rpetrano@stream@twitch.tv)"

#exec ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f pulse -i twitch.monitor -f flv -ac 2 -ar $AUDIO_RATE \
#  -vcodec libx264 -g $GOP -keyint_min $GOPMIN -b:v $CBR -minrate $CBR -maxrate $CBR -pix_fmt yuv420p\
#  -s $OUTRES -preset $QUALITY -tune film -acodec libmp3lame -threads $THREADS -strict normal \
#  -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"

	#-f pulse -ac 2 -i twitch.monitor\
	#-c:a libmp3lame -ab 96k -ar 22050 -strict normal -threads 0\
# ffmpeg\
# 	-f x11grab -s "$INRES" -r "$FPS" -i :0.0\
# 	-c:v libx264 -preset "$quality" -pix_fmt yuv420p -s "$OUTRES"\
# 		-b:v "3000k" -minrate "3000k" -maxrate "3000k" -bufsize 10M\
# 		-g 60 -keyint_min 30\
# 	-f flv -threads 0  - | vlc -

# -x264opts preset=faster,minrate=3300,maxrate=3300,bufsize=3300,keyint=120
#	-c:v libx264 -b:v 3300k -preset:v ultrafast -pix_fmt yuv420p\
ffmpeg -v warning\
	-f x11grab -s 1920x1080 -r 30 -i :0.0\
	-f pulse -ac 2 -i jack_in_twitch\
	-c:v libx264 -b:v 1500k -preset:v veryfast -pix_fmt yuv420p\
	-c:a libfdk_aac -ar 96000 -b:a 160k\
	-f flv "rtmp://live-fra.twitch.tv/app/$STREAM_KEY"
