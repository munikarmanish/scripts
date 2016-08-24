#!/bin/bash
#
# umme.sh: Makes files unexecutable
#
###############################################################################

PROGRAM="unme.sh"       # Program name

R_FLAG=0        # Recursive option flag
Q_FLAG=0        # Quiet option flag

# Terminal colors
NC="\e[1;0m"
RED="\e[1;31m"

print_help ()
{
  echo "Usage: $PROGRAM [options] [files]"
  echo
  echo "Options:"
  echo "  -r, --recursive     recurse into directories"
  echo "  -q, --quiet         don't display the affected files"
  echo "  -h, --help          print this help text"
}

# Parse options
getopt -o 'rqh' -l 'recursive,quiet,help' -n "$PROGRAM" -- "$@" 1>/dev/null || { echo "Use '$PROGRAM --help' for more info"; exit; }
eval set -- $(getopt -o 'rqh' -l 'recursive,quiet,help' -n "$PROGRAM" -- "$@")
while true; do
  case $1 in
    -r|--recursive) R_FLAG=1; shift;;
    -q|--quiet)     Q_FLAG=1; shift;;
    -h|--help)      print_help; exit;;
    --)             shift; break;;
  esac
done

# Get the files
files="$@"
if [[ ! "$files" ]]; then
  if (($R_FLAG)); then
    files=$(find . -mindepth 1 -type f -exec file {} + | grep -iv 'executable' | cut -d: -f1)
  else
    files=$(find . -mindepth 1 -maxdepth 1 -type f -exec file {} + | grep -iv 'executable' | cut -d: -f1)
  fi
fi

# Act on them
for file in $files; do
  if [[ -x "$file" ]]; then
    chmod -f -x $file && { (($Q_FLAG)) || echo -e "$file"; } || { (($Q_FLAG)) || echo -e "${RED}${file}${NC}"; }
  fi
done

# vim: set ts=2 sw=2 et :
