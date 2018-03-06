#!/usr/local/bin/bash
#***********************************************************************#
# NAME
#       
#  my_pass.sh
#
# SYNOPSIS
#       
#  my_pass.sh username database
#
# DESCRIPTION
#
#  Export password from ~./passwd file to connect to the specified
#  resource into $PASS enviroment variable.  Password file format is:
#  resource_name username password 
#
# AUTHOR
#
#  Shmyg
#       
# HISTORY OF CHANGES
# 
#  $Log: my_pass.sh,v $
#  Revision 1.1  2017/07/14 13:01:20  shmyg
#  Merged with shmyg_mis
#
#  Revision 1.1  2004/12/09 15:03:08  serge
#  Added file to retreive password from ~/.passwd file
#
#
#***********************************************************************#

trap "exit 1" 0 1 2 15

PASSWD_FILE=~/.passwd

if [ $# -ne 2 ]
then
 echo Parameters are missing. Usage: $0 username resource
 exit 1
fi

while read resource username password; do
 if [[ $resource = $1 && $username = $2 ]]
 then
  db_pass="${password}"
 fi
done < "${PASSWD_FILE}"

if [ "${db_pass}" = "" ]
then
 echo Password not found. Exiting...
else
 echo "${db_pass}"
fi

exit 0
