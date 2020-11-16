# /bin/bash

echo "********************************************************************"
echo "*                                                                  *"
echo "*                  MAKE ME BOOTABLE!                               *"
echo "*                                                                  *"
echo "*                   {Έκδοση 11.20}                                *"
echo "********************************************************************"
sudo apt ok
echo "Η λίστα με τα συνδεδεμένα φλασάκια θα εμφανιστεί: "; sleep 5;
ls -la /dev/disk/by-id/ | grep "usb-" | grep -w "sd[b-z]"
sleep 3;
echo "Επιλέξτε το drive όπου θέλετε να γίνει bootable:  π.χ sdb";  sleep 10;
  read ADDRESS
zenity --warning \
--text="ΣΙΓΟΥΡΕΥΤΕΙΤΕ ΟΤΙ ΕΠΙΛΕΞΑΤΕ ΤΟ ΣΩΣΤΟ DRIVE!!!!!"
sleep 3;

FILE=`zenity --file-selection --title="Επιλέξτε ένα ISO αρχείο"`
case $? in
         0)
                echo "\"$FILE\" επιλέχτηκε.";;
         1)
                echo "Δεν επιλέχτηκε αρχείο";;
        -1)
                echo "Προέκυψε ενα σφάλμα.";;
esac
(
echo "10" ; sleep 1
echo "# Προετοιμασία.."
echo "20" ; sleep 1
echo "50" ; sleep 1
echo "# Αντιγράφεται το αρχείο ISO.." 
sudo dd if=$FILE of=/dev/$ADDRESS bs=1M;
echo "75" ; sleep 1
echo "# Αποτελειώνεται η εργασία και γίνεται εξαγωγή.." ; sleep 6
sudo unmount /dev/$ADDRESS
echo "100" ; sleep 4
echo "# Τελείωσε!"
) |
zenity --progress \
  --title="Writing Image.." \
  --text="Version 11.20" \
  --percentage=0

if [ "$?" = -1 ] ; then
        zenity --error \
          --text="An error occurred during writing"
fi