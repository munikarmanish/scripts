#!/bin/bash
#
# aur_backup.sh: Script to backup the AUR directory
#
###############################################################################

AUR="/home/manish/aur"          # The AUR directory
AURB="/E/app/linux/aur"   # The backup AUR directory

# Copy everything to it
rsync -ruvh --delete $AUR/ $AURB/ | sed '/^skipping/d'
