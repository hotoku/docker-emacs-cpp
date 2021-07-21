FROM alpine:3.14.0

RUN apk update && \
    apk add \
    emacs \
    tmux

RUN apk add git
RUN apk add openssh

WORKDIR /root
