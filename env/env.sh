if [[ "${1}" == "mac" ]]
then
  # mac environment variables
  DOCKER_SOCKET=/var/run/docker.sock
  MOUNT=~/.dev-env
  WORKSPACE=~/Development/workspace
  SSH=~/.ssh
  SUDO=""
else
  # all other environments
  DOCKER_SOCKET=/var/run/docker.sock
  MOUNT=~/.dev-env
  WORKSPACE=~/workspace
  SSH=~/.ssh
  SUDO="sudo"
fi
