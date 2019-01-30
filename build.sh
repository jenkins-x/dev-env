#!/bin/bash

export DOCKER_BUILDKIT=1

docker build -t cagiti/dev-env .
