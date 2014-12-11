#!/bin/bash
function hcenter {
 
  text="$1"
 
  cols=`tput cols`
 
  IFS=$'\n'$'\r'
  for line in $(echo -e $text); do
 
    line_length=`echo $line| wc -c`
    half_of_line_length=`expr $line_length / 2`
    center=`expr \( $cols / 2 \) - $half_of_line_length`
 
    spaces=""
    for ((i=0; i < $center; i++)) {
      spaces="$spaces "
    }
 
    echo "$spaces$line"
 
  done
 
}

export TERM='xterm-256color'
hcenter "Welcome to the HP ESS Development Environment!"
hcenter "**********************************************"
. /root/.bashrc

ROOT_PASSWORD=${ROOT_PASSWORD:-password}
echo "root:$ROOT_PASSWORD" | chpasswd

if [ "$#" -eq 0 ]; then
  # Check if this is a ssh connection
  if [ ! -z "$SSH_CLIENT" ]; then
    SSH_ORIGINAL_COMMAND=${SSH_ORIGINAL_COMMAND:-/bin/bash}
    /bin/sh -c $SSH_ORIGINAL_COMMAND
  else 
    echo " => You did not specify a command to run, therefore starting supervisor and sshd"
    echo " => You can login via ssh with username: root, password: $ROOT_PASSWORD"
    echo " => Wemux users can login with username: devenv, password: devenv"
    supervisord -c /etc/supervisord.conf
  fi
else
  echo " => Executing: $*"
  $*
fi
