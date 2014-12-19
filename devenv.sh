#!/bin/bash
echo "****************************************************"
echo "*  Welcome to the HP ESS Development Environment!  *"
echo "****************************************************"

if [ "$#" -eq 0 ]; then
  # Check if this is a ssh connection
  if [ ! -z "$SSH_CLIENT" ]; then
    SSH_ORIGINAL_COMMAND=${SSH_ORIGINAL_COMMAND:-/bin/bash}
    /bin/sh -c $SSH_ORIGINAL_COMMAND
  else 
    PASSWORD=${PASSWORD:-password}
    WEMUX_PASSWORD=${WEMUX_PASSWORD:-wemux}
    echo "$PASSWORD" | sudo passwd --stdin devenv 2>&1 >/dev/null
    echo "$WEMUX_PASSWORD" | sudo passwd --stdin wemux 2>&1 >/dev/null

    echo " => You did not specify a command to run, therefore starting supervisor and sshd"
    echo " => You can login via ssh with username: devenv, password: $PASSWORD"
    echo " => Wemux users can connect with username: wemux, password: $WEMUX_PASSWORD"
    supervisord -c /etc/supervisord.conf
  fi
else
  . /root/.bashrc
  echo " => Executing: $*"
  $*
fi
