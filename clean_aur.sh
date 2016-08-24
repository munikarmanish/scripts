#!/bin/bash
#
# clean_aur.sh: Script to sanitize the AUR directory
#
###############################################################################

### Primary message
h1 () { echo -e "${GREEN}==>${ALL_OFF} ${BOLD}$@${ALL_OFF}"; }

### Secondary message
h2 () { echo -e "    ${BOLD}-${ALL_OFF} ${BLUE}$@${ALL_OFF}";    }

### Tertiary message
h3 () { echo -e "        $@";  }

###############################################################################

aur='/home/manish/aur'                          # The AUR directory
pkgs=$(ls -p $aur | grep '/$' | cut -d/ -f1)    # The list of packages in $aur

n_src=1             # Number of latest source files to keep
n_pkg=2             # Number of latest package files to keep

ALL_OFF="\e[1;0m"   # Terminal colors
BOLD="\e[1;1m"
BLUE="\e[1;34m"
GREEN="\e[1;32m"
RED="\e[1;31m"
YELLOW="\e[1;33m"

h1 "Cleaning package files"
for pkg in $pkgs; do
    # Get the old package files (keep latest $n)
    olds=$(ls -t $aur/$pkg-[0-9r][^a-z]*.pkg.tar.xz 2>/dev/null | tail -n +$(($n_pkg + 1)))
    [[ "$olds" ]] || continue

    h2 "$pkg"
    for old in $olds; do
        h3 "$(basename $old)"
        # Remove here
        rm $old
    done

    # remove all symlinks
    ls -F $aur/$pkg | grep @$ | cut -d@ -f1 | xargs -I{} rm $aur/$pkg/{}
done
