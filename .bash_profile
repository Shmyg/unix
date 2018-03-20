unset USERNAME

PATH=$PATH:$HOME/bin:/sbin:$HOME/work/shmyg_misc/perl:/usr/sbin:/sbin
EDITOR=vi
LANG=en_GB.UTF8
#JAVA_HOME=/usr/lib/jvm/jdk1.6.0_23
#CLASSPATH=$JAVA_HOME/jre/lib:$JAVA_HOME/lib:/opt/app1/oracle/product/11.2.0/dbhome_2/jdk/lib/
PATH=$PATH:$JAVA_HOME/bin
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib:$ORACLE_HOME/jdbc/lib/classes12.jar
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/oracle/11.2/client64/lib

export JAVA_HOME CLASSPATH TNS_ADMIN
export LIBPATH SQLPATH NLS_LANG CVSROOT WORK_DIR LANG
export LOG_DIR PATH EDITOR http_proxy BROWSER NLS_DATE_FORMAT
export ORACLE_HOME ORACLE_SID PATH LD_LIBRARY_PATH CVSROOT

PS1="\u@\H:\w \A $ "
