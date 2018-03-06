#!/bin/bash

DATA_FILE=/home/shmyg/TMP/data.txt
CUSTCODE_FILE=/home/shmyg/TMP/bank1.txt
PHONE_FILE=/home/shmyg/TMP/bank2.txt
DISCARD_FILE=/home/shmyg/TMP/bank3.txt
GLOBAL_FILE=/home/shmyg/TMP/bank.txt

cat $DATA_FILE | \
# Removing all the line breaks and replacing ---- with line break
/usr/bin/perl -e 'while (<STDIN>) {  $str=$_; if ( $str =~ /^-/) {print "\n" ;} else {chop $str; print "${str} ";} }' | \
# Replacing ~ in 'purpose of payment' field with |
awk -F "|" '{
 gsub( "~", "|", $5 ) ;
 printf ( "%s\n", $5 );
}'