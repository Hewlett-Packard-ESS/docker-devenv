# hpess/devenv
This is a container which has all of the tools required to dev in our environment such as:
  - Ruby
  - Rake
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
