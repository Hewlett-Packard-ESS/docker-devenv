#!/bin/bash
if [ "$#" -eq 0 ]; then
  echo "****************************************************"
  echo "*  Welcome to the HP ESS Development Environment!  *"
  echo "****************************************************"

  devenv_password=${devenv_password:-password}
  devenv_wemux_password=${devenv_wemux_password:-wemux}
  echo "$devenv_password" | passwd --stdin hpess 2>&1 >/dev/null
  echo "$devenv_wemux_password" | passwd --stdin wemux 2>&1 >/dev/null

  echo " => Primary logon username: hpess, password: $devenv_password"
  echo " => Wemux logon username: wemux, password: $devenv_wemux_password"
fi
