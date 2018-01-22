#!/bin/bash

### generate a case-sensitive filesystem on a case-sensitive filesystem
# instructions:
## create the disk and mount it
#sudo -p mkdir /mnt
#sudo chmod 777 /mnt
#DDMG=workdisk
#hdiutil create -volname ${DDMG} -type SPARSE -fs 'Case-sensitive Journaled HFS+' -size 20g ~/${DDMG}.dmg
#hdiutil attach "${HOME}/${DDMG}.dmg.sparseimage" -mountpoint /mnt/${DDMG}
#
## stick the disk's uuid into a file
#diskutil info /mnt/${DDMG} |grep UUID |awk '{print $3}' > "${HOME}/.${DDMG}.uuid"
#
## add code to .bash_profile to mount this if not already mounted
## if I could instead figure out how to use automount for this, I would be happy.
#DDMG=workdisk
#DUUID=$(cat ~/.${DDMG}voluuid)
#DMNT=$(diskutil info ${DUUID} | grep "Mount Point" | awk '{ print $3 }')
#if [[ "$DMNT" == "" ]]; then
#    hdiutil attach "${HOME}/${DDMG}.dmg.sparseimage" -mountpoint /mnt/${DDMG}
#fi
#
## ref: http://www.nrtm.org/index.php/2013/05/28/case-sensitivity-on-macosx/
## todo: http://virtuallyhyper.com/2013/07/mount-various-file-system-with-autofs-on-mac-os-x-mountain-lion/
## end instructions


# this stuff gets put into bash_profile/bashrc
#DDMG=workdisk
#DUUID=$(cat ~/.${DDMG}.uuid)
#DMNT=$(diskutil info ${DUUID} | grep "Mount Point" | awk '{ print $3 }')
#if [[ "$DMNT" == "" ]]; then
#    hdiutil attach "${HOME}/${DDMG}.dmg.sparseimage" -mountpoint /mnt/${DDMG}
#fi
### end case-sensitive filesystem

