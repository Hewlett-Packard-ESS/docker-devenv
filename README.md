# hpess/devenv
This is a container which has all of the tools required to dev in our environment such as:
  - Ruby (with Rake, bundler)
  - node.js (with grunt)

It builds on the foundations of hpess/base

## Use
```
docker run -i -t hpess/devenv
```

## Easier Use
Use the example fig file which will mount in your source code into your working directory, then:
```
fig up
fig start
fig stop
```

And you'll get:
```
HP ESS Development Environment
Node Version: v0.10.33
Ruby Version: ruby 2.0.0p353 (2013-11-22) [x86_64-linux]
```
