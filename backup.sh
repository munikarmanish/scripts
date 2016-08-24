#!/bin/bash
#
#   backup.sh: Script to backup important files from Linux to Windows
#              partition.
#
###############################################################################

# Level 1 message
h1() { echo -e "${GREEN}==>${NOCOLOR} ${BOLD}$@${NOCOLOR}"; }

# Level 2 message
h2() { echo -e "$    ${BOLD}-${NOCOLOR} ${BLUE}$@${NOCOLOR}"; }

# Error message
error() { echo -e "${RED}ERROR:${NOCOLOR} ${YELLOW}$@${NOCOLOR}"; }


################### END OF FUNCTIONS #########################################

# Terminal colors

NOCOLOR="\e[1;0m"
BOLD="\e[1;1m"
BLUE="\e[1;34m"
GREEN="\e[1;32m"
RED="\e[1;31m"
YELLOW="\e[1;33m"


# Backup BCT files

BCTDIR="/home/manish/bct"
BCTBACKUPDIR="/E/bct"

h1 "Backing up BCT files..."
rsync -ruvh --exclude='*.git/**' --exclude='**a.out' --delete-excluded \
    $BCTDIR/ $BCTBACKUPDIR/ \
    | sed -e '/^skipping/d' -e '/^sending/d' -e '/^sent/d' -e '/^$/d'


# Backup package files (NO NEED --- BECAUSE PACMAN ALREADY DOES IT --- SEE pacman.conf)
#
#PKGDIR="/var/cache/pacman/pkg"
#PKGBACKUPDIR="/E/app/linux/pacman"
#
#h1 "Backing up pacman packages..."
#rsync -ruvh --delete $PKGDIR/ $PKGBACKUPDIR/ \
    #| sed -e '/^skipping/d' -e '/^sending/d' -e '/^sent/d' -e '/^$/d'
#

## Backup AUR files (NO NEED --- BECAUSE YAOURT ALREADY DOES IT)
#
#AURDIR="/home/manish/aur"
#AURBACKUPDIR="/E/app/linux/aur"
#
#h1 "Backing up AUR packages..."
#rsync -ruvh --delete $AURDIR/ $AURBACKUPDIR/ \
    #| sed -e '/^skipping/d' -e '/^sending/d' -e '/^sent/d' -e '/^$/d'


# Backup scripts

BINDIR="/home/manish/bin"
BINBACKUPDIR="/E/bin"

h1 "Backing up scripts..."
rsync -ruvh $BINDIR/ $BINBACKUPDIR/ \
    | sed -e '/^skipping/d' -e '/^sending/d' -e '/^sent/d' -e '/^$/d'


# Backup images

IMGDIR="/home/manish/img"
IMGBACKUPDIR="/E/img"

h1 "Backing up images..."
rsync -ruvh $IMGDIR/ $IMGBACKUPDIR/ \
    | sed -e '/^skipping/d' -e '/^sending/d' -e '/^sent/d' -e '/^$/d'


# Backup code

CODEDIR="/home/manish/code"
CODEBACKUPDIR="/E/code"

h1 "Backing up codes..."
rsync -ruvh $CODEDIR/ $CODEBACKUPDIR/ --exclude='**a.out' --delete-excluded\
    | sed -e '/^skipping/d' -e '/^sending/d' -e '/^sent/d' -e '/^$/d'

