unset USERNAME

PATH=$PATH:$HOME/bin:/sbin:$HOME/work/shmyg_misc/perl:/usr/sbin:/sbin:/usr/local/bin
EDITOR=vi
LANG=en_GB.UTF8
PATH=$PATH:/home/shmyg/instantclient_11_1
LD_LIBRARY_PATH=/home/shmyg/instantclient_11_1
TNS_ADMIN=/home/shmyg/instantclient_11_1
SQLPATH=/home/shmyg/instantclient_11_1

export JAVA_HOME CLASSPATH LIBPATH PATH EDITOR http_proxy BROWSER LD_LIBRARY_PATH TNS_ADMIN SQLPATH
#PS1="\u@\H:\w \A $ "
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[\033[01;32m\]\A\[\033[00m\] \$ '
