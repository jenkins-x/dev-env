SHELL := /bin/bash

all: build

build:
	DOCKER_BUILDKIT=1 docker build -t cagiti/dev-env .

.PHONY: build


