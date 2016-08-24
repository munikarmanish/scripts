#!/bin/bash
#
# aur.sh: Install an AUR package and store the package file
#
# It uses package-query.
#
###############################################################################

# Directories
aurdir="/home/manish/aur"
srcdir="${aurdir}/src"
pkgdir="/E/app/linux/aur"

# Check if targets are specified
targets=($@)
[[ ${#targets[@]} > 0 ]] || { echo "Usage: $(basename $0) <targets...>" && exit 1; }

# Build the list of valid package files to install
pkgs=$(package-query -A -f "%n-%V*.pkg.tar.xz" ${targets[@]})

# Make those fucking packages
for pkg in ${targets[@]}; do
  if yaourt -Sasq ${pkg} | grep "^${pkg}$" &>/dev/null; then
    # Check if package already exists
    pkgfile=$(package-query -A -f "%n-%V*.pkg.tar.xz" ${pkg})
    if ls ${pkgdir}/${pkgfile} &>/dev/null; then continue; fi

    # Make the package here
    cd ${aurdir}
    yaourt -G ${pkg} --noconfirm &>/dev/null
    cd ${aurdir}/${pkg}
    makepkg -sfc --noconfirm
  else
    echo ":: Package '${pkg}' doesn't exist!"
  fi
done

# Install those fucking packages
cd ${pkgdir}
yaourt -U ${pkgs[@]}

# vim:set ts=2 sw=2 et:
