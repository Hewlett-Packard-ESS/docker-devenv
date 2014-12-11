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

ROOT_PASSWORD=${ROOT_PASSWORD:-password}
echo "root:$ROOT_PASSWORD" | chpasswd

if [ "$#" -eq 0 ]; then
  echo " => You did not specify a command to run, therefore starting supervisor and sshd"
  echo " => You can login via ssh with username: root, password: $ROOT_PASSWORD"
  supervisord -c /etc/supervisord.conf
else
  echo " => Executing: $*"
  $*
fi
