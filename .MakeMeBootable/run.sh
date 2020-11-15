# /bin/bash

echo "********************************************************************"
echo "*                                                                  *"
echo "*                  MAKE ME BOOTABLE!                               *"
echo "*                                                                  *"
echo "*                   {Version 0.3}                                  *"
echo "********************************************************************"

echo "Now the list of connected devices will appear.."; sleep 5;
sudo fdisk -l
sleep 3;
echo "Select the drive that you want to format and make bootable your iso: ** WARNING THIS SELECTED DRIVE WILL BE FORMATED!!!"; sleep 10;
  read ADDRESS

FILE=`zenity --file-selection --title="Select an ISO File"`

case $? in
         0)
                echo "\"$FILE\" selected.";;
         1)
                echo "No file selected.";;
        -1)
                echo "An unexpected error has occurred.";;
esac
(
echo "10" ; sleep 1
echo "# Getting Ready"
echo "20" ; sleep 1
echo "50" ; sleep 1
echo "# Writing Image..." 
sudo dd if=$FILE of=$ADDRESS bs=1M;
echo "75" ; sleep 1
echo "# Finishing and Unmounting Selected device..." ; sleep 6
sudo unmount $ADDRESS
echo "100" ; sleep 4
echo "# Finished!"
) |
zenity --progress \
  --title="Writing ISO to drive" \
  --text="Version 0.01" \
  --percentage=0

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="An error occurred during writing"
fi
