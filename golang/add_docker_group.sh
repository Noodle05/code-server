#!/bin/bash

if [[ -n "$DOCKER_GID" ]]; then
    groupadd -g $DOCKER_GID -o -r -f docker
    usermod -aG docker abc
fi
