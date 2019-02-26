FROM jenkinsxio/jx:1.3.930 as jx
FROM lachlanevenson/k8s-kubectl:v1.13.3 as kubectl
FROM lachlanevenson/k8s-helm:v2.12.3 as helm
FROM google/cloud-sdk:alpine as gcloud
FROM golang:1.11-alpine3.8

ARG user=developer
ARG group=developer
ARG home=/home/${user}
ARG uid=1000
ARG gid=1000
ENV HUB_VERSION 2.7.0
ENV DEP_VERSION 0.5.0
ENV GOPATH ${home}/go-workspace
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
ADD ./env/default/.vim/colors/molokai_dark.vim /tmp/colors/molokai_dark.vim
WORKDIR /

# Add developer user
RUN mkdir -p ${home} \
    && addgroup -g ${gid} ${group} \
    && adduser -h ${home} -u ${uid} -G ${group} -s /bin/bash -D ${user} \
    && mkdir -p $GOPATH/src $GOPATH/bin
# Install standard dependencies
RUN apk --no-cache --update add \
       vim \
       grep \
       tar \
       dos2unix \
       shadow \
       gcc \
       libc-dev \
       ca-certificates \
       docker \
       tree \
       jq \
       multitail \
       ngrep \
       nmap \
       unzip \
       wget \
       curl \
       openjdk8 \
       git \
       git-perl \
       git-email \
       tig \
       bash \
       tmux \
       make \
       terraform \
       python \
       py-crcmod \
       libc6-compat \
       openssh-client \
       gnupg \
       openssl \
    # Install hub-cli
    && curl -sL https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz | tar zx --strip 2 -C /usr/local/bin hub-linux-amd64-${HUB_VERSION}/bin/hub \
    # Setup Docker hack - there must be a better way
    && usermod -a -G docker ${user} \
    && usermod -a -G root ${user} \
    # Install dep
    && curl -sL https://raw.githubusercontent.com/golang/dep/v${DEP_VERSION}/install.sh | sh \
    # Configure vi environment
    && mkdir -p /home/${user}/.vim/pack/plugins/start \
    && rm /usr/bin/vi && ln -s /usr/bin/vim /usr/bin/vi \
    && go get golang.org/x/tools/cmd/gorename \
    && go get github.com/nsf/gocode \
    && $GOPATH/bin/gocode set propose-builtins true \
    && git clone https://github.com/fatih/vim-go.git /home/${user}/.vim/pack/plugins/start/vim-go \
    && git clone https://github.com/manniwood/vim-buf.git /home/${user}/.vim/pack/plugins/start/vim-buf \
    && mv /tmp/colors /home/${user}/.vim \
    && chown -R ${user}:${group} /home/${user}

COPY --from=jx /usr/bin/jx /usr/local/bin/jx
COPY --from=kubectl /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=helm /usr/local/bin/helm /usr/local/bin/helm
COPY --from=gcloud /google-cloud-sdk /usr/local/google-cloud-sdk

# gcloud configurations
ENV PATH /usr/local/google-cloud-sdk/bin:$PATH
RUN ln -s /lib /lib64 \
    && gcloud config set core/disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true \
    && gcloud config set metrics/environment github_docker_image

# Install pre-commit (https://pre-commit.com/)
RUN curl -sL https://pre-commit.com/install-local.py | python -
ENV PATH /home/${user}/bin:$PATH

# Setup Environment
USER ${user}
# Install ko
RUN go get -u github.com/google/go-containerregistry/cmd/ko
WORKDIR /home/$user/go-workspace
