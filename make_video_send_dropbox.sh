#!/bin/bash
#===================================================================================
#  make_video_send_dropbox.sh
#
# this script:
#    1) makes a list of all jpg files
#    2) makes a video timelapse of all the files
#    3) sends the output file (timelapse.avi) up to dropbox
#    4) moves all daily jpg files to archive folder
#
#===================================================================================
#
DATE=$(date +"%Y-%m-%d_%H%M")

echo " "
echo "===================================="
echo " Running make_video_send_dropbox.sh "
echo DATE
echo " "
echo "===================================="
echo " "

# move all the jpg files and the avi file just created to the archive folder 
echo " "
echo "archiving all files processed during last run..."
echo " "
sudo mv /var/www/html/*.jpg /var/www/html/archive
sudo mv /var/www/html/*.avi /var/www/html/archive
sudo rm stills.txt

# make a video of all the jpg files from the day
echo " "
echo "turning all jpg files into timelapse video file. please wait..."
echo " "
cd /var/www/html
sudo ls /var/www/html/*.jpg > stills.txt
sudo mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1920:1080 -o timelapse.avi -mf type=jpeg:fps=24 mf://@stills.txt

# upload the avi file we just created to Dropbox via API
echo " "
echo "uploading the video file just produced up to the dropbox share..."
echo " "
cd /home/pi/Dropbox-Uploader
sudo ./dropbox_uploader.sh -sp upload /var/www/html/*.avi Cabin_RaspberryPi_Cam1

echo " "
echo "All tasks complete!"
echo " "
