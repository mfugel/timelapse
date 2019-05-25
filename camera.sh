#!/bin/bash
#====================================================================
# CAMERA.SH
# this script uses the pi camera to take a picture and
# will output it into the folder below with a timestamp 
# as the name 
# see this link: https://pimylifeup.com/raspberry-pi-time-lapse/
#
#  Raspistill can do timelapse on it’s own without needing to use crontab.
#
#  raspistill -vf -hf -w 1280 -h 720 -o time_%04d.jpg -tl 18000 -t 1080000
#      -vf is vertical flip since my camera is upside down
#      -hf – horizontal flip since the image is mirrored
#      -w – width. The native resolution is quite high so I just capture at 720p resolution
#      -h – height
#      -o Output file name and location. %04d tells it to use a 4 digit incremental number to name the files
#      -tl – duration between images. If this is low, say under 2 seconds you may want to use -bm for burst mode. This keeps the camera active and you’ll have fewer dropped frames
#      -t – total capture time. These are both in milliseconds so in the above example I was taking an image every 18 seconds for 3 hours which gives me 600 images and at 10 frames/second that is a 1 minute video.
#
#
#====================================================================
DATE=$(date +"%Y-%m-%d_%H%M")
raspistill -hf -vf -o /home/pi/timelapse/$DATE.jpg
mv /home/pi/timelapse/*.jpg /var/www/html

