FROM golang:1.11-alpine3.8

ARG user=developer
ARG group=developer
ARG home=/home/${user}
ARG uid=1000
ARG gid=1000
ENV HUB_VERSION 2.7.0
ENV KUBCTL_VERSION v1.6.4
ENV JX_VERSION v1.3.731
ENV CLOUD_SDK_VERSION 229.0.0
ENV PATH /google-cloud-sdk/bin:$PATH
WORKDIR /

# Add developer user
RUN mkdir -p ${home} \
    && addgroup -g ${gid} ${group} \
    && adduser -h ${home} -u ${uid} -G ${group} -s /bin/bash -D ${user} \
    # Install standard dependencies
    && apk --no-cache --update add \
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
       bash \
       tmux \
       make \
       terraform \
       python \
       py-crcmod \
       libc6-compat \
       openssh-client \
       gnupg \
    # Install gcloud cli
    && curl -sLO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz \
    && ln -s /lib /lib64 \
    && gcloud config set core/disable_usage_reporting true \
    && gcloud config set component_manager/disable_update_check true \
    && gcloud config set metrics/environment github_docker_image \
    && gcloud --version \
    # Install kubectl
    && curl -sL https://storage.googleapis.com/kubernetes-release/release/${KUBCTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    # Install jx
    && curl -sL https://github.com/jenkins-x/jx/releases/download/${JX_VERSION}/jx-linux-amd64.tar.gz | tar xz -C /usr/local/bin \
    && curl -sL https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz | tar zx --strip 2 -C /usr/local/bin hub-linux-amd64-2.7.0/bin/hub \
    # Setup Docker hack - there must be a better way
    && usermod -a -G docker ${user} \
    && usermod -a -G root ${user} \
    && rm /usr/bin/vi && ln -s /usr/bin/vim /usr/bin/vi

# Setup Environment
USER ${user}
ENV PS1='$(echo -e "'"\U1F645"'") \[\033[32m\]\u \[\033[33m\]\w($(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p"))\[\033[00m\]$ '
ENV PATH /google-cloud-sdk/bin:$PATH
WORKDIR /go/src
