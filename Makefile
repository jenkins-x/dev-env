SHELL := /bin/bash
DOCKER := DOCKER_BUILDKIT=0 docker
DOCKERFILE := Dockerfile

all: build

build:
	$(DOCKER) build --tag gcr.io/jenkinsxio/dev-env \
			--file $(DOCKERFILE) .

.PHONY: build


