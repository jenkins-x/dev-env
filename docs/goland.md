# GoLand
_This is a guide for executing goland using a docker container. The container image is maintained by [rycus86](https://hub.docker.com/r/rycus86/goland/)_

## overview
The intention of executing [GoLand](https://www.jetbrains.com/go/) through a docker container is to enable an easier upgrade path with minimal user maintenance.

## prerequisites
You'll need:
- [Docker](https://www.docker.com/), see [Docker for MacOS](https://hub.docker.com/editions/community/docker-ce-desktop-mac).
- [XQuartz](https://www.xquartz.org/)

## run
To execute the dev-env, perform the following:
```
$ git clone https://github.com/jenkins-x/dev-env
$ cd dev-env
$ ./goland
```
## support
The execution of this GoLand container has only been verified on **MacOS**.
