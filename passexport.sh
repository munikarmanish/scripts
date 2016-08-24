#!/bin/bash
#
#   Export password to external file
#

# The password directory
PASS_DIR="/home/manish/.password-store"

# The output file
OUT_FILE="/home/manish/.passexport"

# Backup the old export file
mv ${OUT_FILE} ${OUT_FILE}.old

for file in "${PASS_DIR}"/*.gpg "${PASS_DIR}"/**/*.gpg; do

    # Remove the prefix and extension (get the username)
    username=${file/"$PASS_DIR/"/}
    username=${username%.gpg}

    # Print username
    echo ${username} >> ${OUT_FILE}
    # Print password
    pass ${username} >> ${OUT_FILE}

done
