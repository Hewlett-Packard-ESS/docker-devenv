#!/bin/bash
echo "****************************************************"
echo "*  Welcome to the HP ESS Development Environment!  *"
echo "****************************************************"

PASSWORD=${PASSWORD:-password}
echo "$PASSWORD" | sudo passwd --stdin devenv 2>&1 >/dev/null

if [ "$#" -eq 0 ]; then
  # Check if this is a ssh connection
  if [ ! -z "$SSH_CLIENT" ]; then
    SSH_ORIGINAL_COMMAND=${SSH_ORIGINAL_COMMAND:-/bin/bash}
    /bin/sh -c $SSH_ORIGINAL_COMMAND
  else 
    echo " => You did not specify a command to run, therefore starting supervisor and sshd"
    echo " => You can login via ssh with username: devenv, password: $PASSWORD"
    supervisord -c /etc/supervisord.conf
  fi
else
  . /root/.bashrc
  echo " => Executing: $*"
  $*
fi
