#!/bin/bash

# Script for processing payment files from banks
# Parses files and creates input files for SQLLoader
# Creates 3 files:
# 1 - amount | custcode
# 2 - amount | phone_number
# 3 - discarded records
# Created by Shmyg with great help from San and Sobko

DATA_FILE=/home/shmyg/TMP/data.txt
CUSTCODE_FILE=/home/shmyg/TMP/bank1.txt
PHONE_FILE=/home/shmyg/TMP/bank2.txt
DISCARD_FILE=/home/shmyg/TMP/bank3.txt

cat $DATA_FILE | \
# Removing all the line breaks and replacing ---- with line break
/usr/bin/perl -e 'while (<STDIN>) {  $str=$_; if ( $str =~ /^-/) {print "\n" ;} else {chop $str; print "${str} ";} }' | \
# Replacing ~ in 'purpose of payment' field with |
sed 's/~/|/g' | \
# Removing unnecessary fields
# Here we should receieve 4 fields: amount, custcode, phone_number and whole string
awk -F "|" '{ printf("%.2f|%s|%s|%s\n"), $4, $6, $8, $0}' | \
# Beginning main processing
awk -F "|" 'BEGIN {printf ("") > "'"$CUSTCODE_FILE"'"; printf ("") > "'"$PHONE_FILE"'"; printf ("") > "'"$DISCARD_FILE"'" }
{
 # Pinning string - if we cannot parse string - will place it in discard file
 string_processed = $0;
 # Replacing commas with dots
 gsub( ",", ".", $0 );
 # Removing all the trash
 gsub( "[^0-9.|]", "", $0 );
 # Removing possible dots in phone number
 gsub( "\\.", "", $3 );
 # Removing possible spaces and dashes in phone number
 gsub( "[[:space:]-]", "", $3 );
 # Trimming possible 50, 050, 8050 from the beginning of phone number
 gsub( "^8*0*50", "", $3 );

 # Splitting all records to different files
 # Checking custcode - it must be not null and begin with 1 digit followed by dot
 if ( length($2) != 0 && match( $2, "^[1-9]\\." ) != 0 ) {
  printf ("%.2f|%s\n", $1, $2 ) >> "'"$CUSTCODE_FILE"'"
 }
 else {
  # Phone number could be in 2nd field
  # Phone number length must be 7 symbold and cannot contain any
  # symbols except digits
  if ( length($2) == 7 && match( $2, "[^[:digit:]]" ) == 0 ) {
   # Here we should add 50 before phone number
   printf ("%.2f|50%s\n", $1, $2 ) >> "'"$PHONE_FILE"'"    
  }
  else {
   # Now we check 3rd field with all the rules described above
   if ( length($3) == 7 && match( $3, "[^[:digit:]]" ) == 0 ) {
    printf ("%.2f|50%s\n", $1, $3 ) >> "'"$PHONE_FILE"'"    
   }
   else {
    # The last resort - we should not be here, but...
    printf ("%s\n", string_processed ) >> "'"$DISCARD_FILE"'"
   }
  }
 }
}'
