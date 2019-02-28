#!/bin/bash

export PS1='$(echo -e "'"\U1F645"'") \[\033[32m\]\u \[\033[33m\]\w($(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p"))\[\033[00m\]$ '
export JAVA_HOME=$(dirname $(readlink -f $(which java)) | sed 's:/bin::')

function load_ssh_key(){
  if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s` >/dev/null
    ssh-add >/dev/null 2>/dev/null
  fi
}

function setup_aliases(){
  alias l='ls -l'
  alias ll='ls -la'
  alias tmux='tmux -u'
  alias t='tmux -u'
  alias kc='kubectl'
}

function setup_hub(){
  eval "$(hub alias -s)"
}

setup_aliases
load_ssh_key
setup_hub
