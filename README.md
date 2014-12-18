# hpess/devenv
This container builds on hpess/base by adding a bunch of common dev environment tools, such as:
 - git
 - tmux/wemux
 - vim

## Use
On it's own it isn't much use, it's designed to be the base for language specific dev environments, such as: 
 - https://github.com/Hewlett-Packard-ESS/docker-devenv-nodejs

fig.yml:
```
devenv:
  image: hpess/devenv
  environment:
    - PASSWORD=secret
  ports:
    - '8022:22'
```
or in line:
```
docker run -p 8022:22 hpess/devenv
```
results in:
```
devenv_1 | ***************************************************
devenv_1 | *  Welcome to the HP ESS Development Environment!  
devenv_1 | ***************************************************
devenv_1 |  => You did not specify a command to run, therefore starting supervisor and sshd
devenv_1 |  => You can login via ssh with username: devenv, password: secret
devenv_1 | 2014-12-11 16:38:44,898 CRIT Set uid to user 0
devenv_1 | 2014-12-11 16:38:44,898 WARN Included extra file "/etc/supervisord.d/sshd.service.conf" during parsing
devenv_1 | 2014-12-11 16:38:44,939 INFO RPC interface 'supervisor' initialized
devenv_1 | 2014-12-11 16:38:44,939 CRIT Server 'unix_http_server' running without any HTTP authentication checking
devenv_1 | 2014-12-11 16:38:44,939 INFO supervisord started with pid 11
devenv_1 | 2014-12-11 16:38:45,945 INFO spawned: 'sshd' with pid 14
devenv_1 | 2014-12-11 16:38:47,110 INFO success: sshd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```
You can specify an exact command to run if you dont want to start sshd, etc
```
docker run hpess/devenv echo "hi"
```
Sudo is installed and devenv has unlimited unpassworded access.
