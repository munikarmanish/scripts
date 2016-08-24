#!/bin/bash
#
# update_mirrorlist.sh: Script to update the mirrorlist using reflector

# Get the latest and fastest mirrors
reflector --verbose --latest 30 --sort rate --save /etc/pacman.d/mirrorlist &&
    yaourt -Syy
