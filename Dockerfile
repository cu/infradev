# syntax=docker/dockerfile:1.4

FROM ubuntu:22.04
ARG TARGETARCH

ARG TERRAFORM_VERSION=1.2.2
ARG TFZIP=terraform_${TERRAFORM_VERSION}_linux_$TARGETARCH.zip

ARG DEBIAN_FRONTEND=noninteractive
RUN <<EOS sh -ex
    apt-get update
    apt-get install -yq --no-install-recommends \
        curl \
        git \
        vim \
        python-is-python3 \
        python3-venv \
        python3-pip \
        python3-dev \
        sudo \
        unzip
    useradd --create-home --groups adm --shell /bin/bash dev
    echo 'dev ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/dev
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EOS

USER dev
WORKDIR /home/dev
CMD bash -l

RUN <<EOS sh -ex
    pip install --user --no-warn-script-location --upgrade pip
    pip install --user pipx
EOS

RUN <<EOS sh -ex
    ~/.local/bin/pipx install oci-cli
    curl -sSOLf https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/$TFZIP
    unzip -d ~/.local/bin/ $TFZIP
    rm $TFZIP
EOS
