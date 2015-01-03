# hpess/devenv
This container builds on hpess/base by adding a bunch of common dev environment tools, such as:
 - git
 - tmux/wemux
 - vim

## Use
On it's own it isn't much use, it's designed to be the base for language specific dev environments, such as: 
 - https://github.com/Hewlett-Packard-ESS/docker-devenv-nodejs

You need to configure the environment with environment variables.  Personally the easiest way to do this is with a fig file:
```
devenv:
  hostname: 'devenv'
  image: hpess/devenv
  ports:
    - "2022:2022"
  environment:
    devenv_password: 'password'
    devenv_wemux_password: 'password'
    git_name: "Mr Example"
    git_email: "mr.example@domain.com"
    git_ssl_verify: "false"
```
Then typing `sudo fig up devenv` results in:
```
****************************************************
*  Welcome to the HP ESS Development Environment!  *
****************************************************
 => Primary logon username: hpess, password: password
 => Wemux logon username: wemux, password: wemux
```
From there you can SSH into the container, it's listening by default on 2022.

## No SSH
If you're not wanting to use SSH to get into the container, you can specify an exact command to run if you dont want to start sshd, etc
```
sudo fig --rm run devenv echo "hi"
```

## Sudo/Admin
Sudo is installed and the hpess user has ALL password-less access.
