#!/bin/sh

# Setting directory
cwd="$(dirname $0)"
cd "$cwd/.."

# Building docker image
docker build --tag happstack-server .