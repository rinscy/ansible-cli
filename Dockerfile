FROM alpine:3.3
MAINTAINER Saïd Bouras <said.bouras@gmail.com>

ENV \
    ANSIBLE_VERSION=2.9

RUN set -x \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && echo "http://dl-4.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && addgroup -S ansible \
    && adduser -D -S -G ansible ansible \
    && apk --update upgrade \
    && apk --no-cache --update add sudo \
        linux-headers \
        build-base \
        ca-certificates \
        python3 \
        python3-dev \
        sshpass \
        libffi-dev \
        openssl-dev \
        openssh-client \
        bash \
    && rm -rf /var/cache/apk/*

RUN if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi \
    && if [[ ! -e /usr/bin/easy_install ]]; then ln -sf /usr/bin/easy_install-3* /usr/bin/easy_install; fi \
    && if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip3 /usr/bin/pip; fi

RUN easy_install pip \
    && pip install --upgrade pip \
    && pip install ansible==${ANSIBLE_VERSION} \
    && pip install redis

ENV ANSIBLE_HOST_KEY_CHECKING=False

# Setup sudo
RUN echo 'ansible       ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers

# Clean
RUN find . -type d -name ".git" | xargs rm -rf

# Set the user by default and define working directory.
USER ansible
WORKDIR /home/ansible

ENTRYPOINT ["/bin/bash"]
