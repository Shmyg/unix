#!/bin/bash

ORACLE_HOME=  ; export ORACLE_HOME
TNS_ADMIN=$ORACLE_HOME/network/admin; export TNS_ADMIN
PATH=$ORACLE_HOME/bin:${PATH}; export PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORACLE_HOME/network/jre11/lib/sparc/native_threads:${LD_LIBRARY_PATH}; export LD_LIBRARY_PATH
ORACLE_TERM=vt220; export ORACLE_TERM
TK60_ICON=$ORACLE_HOME/tools/devdem60/bin/icon; export TK60_ICON
UI_ICON=$TK60_ICON; export UI_ICON
ORACLE_PATH=$ORACLE_HOME/test/forms60:$ORACLE_HOME/test/lib:$ORACLE_HOME/forms60:${ORACLE_PATH}; export ORACLE_PATH
FORMS60_PATH=$ORACLE_HOME/test/forms60; export FORMS60_PATH
FORMS60_TERMINAL=$ORACLE_HOME/forms60/admin/terminal/US; export FORMS60_TERMINAL
NLS_LANG=AMERICAN_AMERICA.CL8ISO8859P5; export NLS_LANG

GLOBAL_DIR=

cd $GLOBAL_DIR
for DIR_NAME in *
do
 cd $DIR_NAME
 for FILENAME in *
 do 
  EXT=${FILENAME#*.}
  if [ "$EXT" = mmb ]
  then
   MODULE_TYPE=MENU
   EXT=mmx
  elif [ "$EXT" = pll ]
  then
   MODULE_TYPE=LIBRARY
   EXT=plx
  else
   MODULE_TYPE=FORM
   EXT=fmx
  fi

  WORK_DIR=`pwd`
  OUTPUT_FILE=${FILENAME%.*}.$EXT
  CONNECT_STRING=$DIR_NAME/$DIR_NAME@test6

  f60genm module=$FILENAME module_type=$MODULE_TYPE strip_source=YES output_file=$OUTPUT_FILE userid=$CONNECT_STRING
  if [ $? = 0 ]
  then
   rm -f ${FILENAME%.*}.err 
   rm -f ${FILENAME%.*}.fmb 
   rm -f ${FILENAME%.*}.mmb 
  fi
 done
done
