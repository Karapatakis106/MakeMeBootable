# /bin/bash

echo "********************************************************************"
echo "*                                                                  *"
echo "*                  MAKE ME BOOTABLE!                               *"
echo "*                                                                  *"
echo "*                   {Version 11.20}                                *"
echo "********************************************************************"
sudo apt ok
echo "Now the list of connected usb drives will appear.."; sleep 5;
ls -la /dev/disk/by-id/ | grep "usb-" | grep -w "sd[b-z]"
sleep 3;
echo "Select the drive that you want to format and make bootable your iso: xxx e.g sdb";  sleep 10;
  read ADDRESS
zenity --warning \
--text="MAKE SURE THAT YOU SELECTED THE CORRECT DRIVE!!"
sleep 3;

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
sudo dd if=$FILE of=/dev/$ADDRESS bs=1M;
echo "75" ; sleep 1
echo "# Finishing and Unmounting Selected device..." ; sleep 6
sudo unmount /dev/$ADDRESS
echo "100" ; sleep 4
echo "# Finished!"
) |
zenity --progress \
  --title="Writing Image.." \
  --text="Version 11.20" \
  --percentage=0

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="An error occurred during writing"
fi