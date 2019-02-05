GOLAND="rycus86/goland:latest"

if [[ "${1}" == "mac" ]]
then
  # mac environment variables
  DOCKER_SOCKET=/var/run/docker.sock
  MOUNT=~/.dev-env
  WORKSPACE=~/Development/workspace
  SSH=~/.ssh
  SUDO=""
  X11_ERROR="DISPLAY environment not set, is X11 installed? See https://www.xquartz.org/releases/index.html for more information"
else
  # all other environments
  DOCKER_SOCKET=/var/run/docker.sock
  MOUNT=~/.dev-env
  WORKSPACE=~/workspace
  SSH=~/.ssh
  SUDO="sudo"
  X11_ERROR="Not supported"
fi
