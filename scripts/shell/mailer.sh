#!/bin/bash

# Script for mailing payment request files to Aval
# Originally written by San for dealer bills
# Reimplemented by Shmyg
# LMD 26.03.2003

export LC_TIME=C

## CONFIG ####################################################################
WORKING_DIR=/tmp
MIMENCODING="base64"
to="shmyg@umc.com.ua"
from="cryptor@umc.com.ua"
subj="Payment request file"
## END OF CONFIG #############################################################

# Report warning or log message
log () {
    echo "$0: `date +\"%d.%m.%Y %H:%M:%S\"`: $@"
}

# Report critical error and terminate immediately
fail () {
    echo "$0: $@"
    exit
}

# Check input, temp and archive directories
check_directory_exists_and_readable () {

    if test ! -d "$WORKING_DIR" ; then
        fail "Directory $WORKING_DIR is not exactly a directory or does not exist"
    fi
    if test ! -r "$WORKING_DIR" ; then
        fail "Directory $WORKING_DIR is not readable"
    fi
}

# Attach and send file using metasend 
attach_and_send () {

    description="Payment request file"

    metasend -b \
             -F "$from" \
             -t "$to" \
             -s "$subj" \
             -D "$description" \
             -e base64 \
             -m "application/octet-stream; name=\"$FILENAME.gpg\"" \
             -f "$1" \
       
    if test $? != 0 ; then
        log "Error sending $1 to $to"
    else
        log "OK sending $1 to $to"
    fi

}


METASEND=`which metasend`
if test ! -f "$METASEND" -o ! -x "$METASEND" ; then
    fail "Metasend ($METASEND) is not a file or not executable"
fi

GPG=`which gpg`
if test ! -f "$GPG" -o ! -x "$GPG" ; then
    fail "GPG ($GPG) is not a file or not executable"
fi

check_directory_exists_and_readable
cd $WORKING_DIR
$GPG -q -r Yugene -f $1
FILENAME=`echo $1 | sed 's/\..*//'`
attach_and_send "$WORKING_DIR/$FILENAME.gpg"