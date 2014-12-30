#!/bin/bash
echo "****************************************************"
echo "*  Welcome to the HP ESS Development Environment!  *"
echo "****************************************************"

devenv_password=${devenv_password:-password}
devenv_wemux_password=${devenv_wemux_password:-wemux}
echo "$devenv_password" | sudo passwd --stdin devenv 2>&1 >/dev/null
echo "$devenv_wemux_password" | sudo passwd --stdin wemux 2>&1 >/dev/null

echo " => Primary logon username: devenv, password: $devenv_password"
echo " => Wemux logon username: wemux, password: $devenv_wemux_password"
