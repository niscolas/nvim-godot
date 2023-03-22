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

COPY ./nvim_config /root/.config/nvim
COPY ./godot_sample_project /godot_sample_project

EXPOSE 6005
EXPOSE 6006

WORKDIR /godot_sample_project
