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
1. Start XQuartz from command line using 
```
open -a XQuartz
```
2. In the XQuartz preferences, go to the “Security” tab and make sure you’ve got “Allow connections from network clients” ticked.

3. Then execute goland using the following docker run command:
```
$ docker run --rm \
             --detach \
             --env DISPLAY=$(hostname):0 \
             --security-opt=seccomp:unconfined \
             --volume ${DISPLAY/:0}:/tmp/.X11-unix \
             --volume ~/.GoLand:/home/developer/.GoLand \
             --volume ~/.GoLand.java:/home/developer/.java \
             --volume ~/Development/go-workspace:/home/developer/go \
             --name goland-$(head -c 4 /dev/urandom | xxd -p)-$(date +'%Y%m%d-%H%M%S') \
             rycus86/goland:latest
```
## support
The execution of this GoLand container has only been verified on **MacOS**.
