# hpess/devenv
This container builds on hpess/base by adding a bunch of common dev environment tools, such as:
 - git
 - tmux/wemux
 - vim

## Use
On it's own it isn't much use, it's designed to be the base for language specific dev environments, such as: 
 - https://github.com/Hewlett-Packard-ESS/docker-devenv-nodejs

```
[root@jambr-dev docker-devenv]# docker run -i -t -p 1337:22 hpess/devenv
                             Welcome to the HP ESS Development Environment!
                             **********************************************
 => You did not specify a command to run, therefore starting supervisor and sshd
 => You can login via ssh with username: root, password: password
2014-12-11 13:58:53,142 CRIT Set uid to user 0
2014-12-11 13:58:53,142 WARN Included extra file "/etc/supervisord.d/sshd.service.conf" during parsing
2014-12-11 13:58:53,166 INFO RPC interface 'supervisor' initialized
2014-12-11 13:58:53,166 CRIT Server 'unix_http_server' running without any HTTP authentication checking
2014-12-11 13:58:53,167 INFO supervisord started with pid 25
2014-12-11 13:58:54,173 INFO spawned: 'sshd' with pid 28
2014-12-11 13:58:55,266 INFO success: sshd entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```
