#!/bin/bash

REPOSITORY_DIR=/home/shmyg/work/shmyg_misc/shell
SED_SCRIPT=$REPOSITORY_DIR/align_sql

if [ ! -f "$1" ]
then
 echo "File $1 doesn't exist!"
 exit
fi

# Looking for select
echo SELECT
sed -f $SED_SCRIPT $1 | \
#egrep "(^| )SELECT " | \
# Looking for all the SELECTs on the line and placing every one to separate line
sed 's/SELECT/\
SELECT /g' | \
# Stripping lines which doesn't contain SELECT
egrep '^SELECT' | \
# Removing all the trash before FROM
sed 's/.* FROM //' | \
# Removing all the trash after WHERE
sed 's/ WHERE .*//' | \
# Removing sql terminator
sed 's/;.*//' | \
# Removing brackets
sed 's/(//g' | \
sed 's/)//g' | \
# Removing empty lines which can occur after brackets removing
egrep '[[:alnum:]]' | \
# Placing every table which could be in SELECT on separate line
sed 's/, /\
/g' | \
# Stripping possible aliases
awk '{ print $1 }' | \
#egrep '[[:alnum:]]' | \
# Removing duplicates and sorting
sort -u 
# Adding blank lines
#awk '{ printf ("%s\n\n", $0) }'

# Looking for select
printf '\n'
echo UPDATE
sed -f $SED_SCRIPT $1 | \
# Looking for all the UPDATEs on the line and placing every one to separate line
sed 's/[[:space:]]\{1,\}UPDATE[[:space:]]\{1,\}/\
UPDATE /g' | \
# Stripping lines which doesn't contain UPDATE
egrep '^UPDATE' | \
# Removing possible UPDATE OF
egrep -v 'UPDATE OF ' | \
# Removing all the trash after SET along with SET clause itself
sed 's/ SET .*//' | \
# Removing UPDATE itself
sed 's/UPDATE //' |\
# Removing sql terminator
#sed 's/;.*//' | \
# Removing brackets
#sed 's/(//g' | \
#sed 's/)//g' | \
# Removing empty lines which can occur after brackets removing
#egrep '[[:alnum:]]' | \
# Placing every table which could be in UPDATE on separate line
#sed 's/, /\
#/g' | \
# Stripping possible aliases
awk '{ print $1 }' | \
egrep '[[:alnum:]]' | \
# Removing duplicates and sorting
sort -u | \
# Adding blank lines 
awk '{ printf ("%s\n", $0) }'

# Looking for insert
printf '\n'
echo INSERT
sed -f $SED_SCRIPT $1 | \
# Looking for all the INSERTs on the line and placing every one to separate line
sed 's/[[:space:]]\{1,\}INSERT[[:space:]]\{1,\}/\
INSERT /g' | \
# Stripping lines which doesn't contain INSERT
egrep '^INSERT' | \
# Removing all the trash before INTO
sed 's/.* INTO //' | \
# Removing all the trash after table name (including space)
sed 's/ .*//' | \
# Removing sql terminator
sed 's/;.*//' | \
# Removing brackets
sed 's/(//g' | \
sed 's/)//g' | \
# Removing empty lines which can occur after brackets removing
egrep '[[:alnum:]]' | \
# Placing every table which could be in UPDATE on separate line
#sed 's/, /\
#/g' | \
# Stripping possible aliases
awk '{ print $1 }' | \
egrep '[[:alnum:]]' | \
# Removing duplicates and sorting
sort -u | \
# Adding blank lines 
awk '{ printf ("%s\n", $0) }'

# Looking for delete
printf '\n'
echo DELETE
sed -f $SED_SCRIPT $1 | \
# Looking for all the DELETEs on the line and placing every one to separate line
sed 's/[[:space:]]\{1,\}DELETE[[:space:]]\{1,\}/\
DELETE /g' | \
# Stripping lines which doesn't contain DELETE
egrep '^DELETE' | \
# Removing all the trash before FROM
sed 's/.* FROM //' | \
# Removing all the trash after table name (including space)
sed 's/ .*//' | \
# Removing sql terminator
sed 's/;.*//' | \
# Removing brackets
sed 's/(//g' | \
sed 's/)//g' | \
# Removing empty lines which can occur after brackets removing
egrep '[[:alnum:]]' | \
# Placing every table which could be in DELETE on separate line
sed 's/, /\
/g' | \
# Stripping possible aliases
awk '{ print $1 }' | \
egrep '[[:alnum:]]' | \
# Removing duplicates and sorting
sort -u | \
# Adding blank lines 
awk '{ printf ("%s\n", $0) }'
