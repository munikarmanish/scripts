#!/bin/bash
#
# upgrade.sh: Script to upgrade packages
#
###############################################################################

trap "exit 1" SIGINT SIGKILL SIGTERM

# Update the official packages first
yaourt -Syu --noconfirm

# Clean the package cache
paccache -vr

# Show the outdated AUR packages. When asked to install, answer no (n).
yaourt -Sua <<<n
