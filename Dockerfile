FROM alpine:latest

RUN apk --no-cache add \
    automake \
    build-base \
    cmake \
    coreutils \
    ctags \
    curl \
    fd  \
    git \
    libtool \
    neovim \
    pkgconf \
    py3-pip\
    ripgrep

RUN pip3 install "gdtoolkit==3.*"

COPY . /root/.config/nvim/
