#!/bin/bash
export TERM='xterm-256color'
echo "****************************************************"
echo "*  Welcome to the HP ESS Development Environment!  *"
echo "****************************************************"

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
  . /root/.bashrc
  echo " => Executing: $*"
  $*
fi
