include .makerc
SHELL := /bin/bash
DOCKER := DOCKER_BUILDKIT=0 docker
DOCKERFILE := Dockerfile

all: build

build:
	$(DOCKER) build --tag cagiti/dev-env \
			--build-arg JX_VERSION=$(JX_VERSION) \
			--build-arg KUBCTL_VERSION=$(KUBCTL_VERSION) \
			--build-arg HELM_VERSION=$(HELM_VERSION) \
			--build-arg GCLOUD_VERSION=$(GCLOUD_VERSION) \
			--file $(DOCKERFILE) .

.PHONY: build


