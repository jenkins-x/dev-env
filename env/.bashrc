#!/bin/bash

function load_ssh_key(){
  if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s` >/dev/null
    ssh-add >/dev/null 2>/dev/null
  fi
}

function setup_aliases(){
  alias l='ls -l'
  alias ll='ls -la'
}

setup_aliases
load_ssh_key
