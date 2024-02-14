#!/bin/bash

#docker run -p 8888:8888 --cpus=4 --platform linux/amd64 docker.io/rajarshitiwari/myqlm:ubuntu@sha256:6c40ac9703b5ff68c3d43d6f97d2699bf32e9c707755fed64332448faf01b02a

docker run -p 8888:8888 --cpus=4 --platform linux/amd64 --mount type=bind,source="$HOME"/dockers,target=/app $1
