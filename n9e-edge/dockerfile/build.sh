#!/bin/bash
SHELL_PATH=$(readlink -f "${BASH_SOURCE[0]}"); echo "SHELL_PATH=[$SHELL_PATH]"; SHELL_DIR=$(dirname $SHELL_PATH); echo "SHELL_DIR=[$SHELL_DIR]"
cd "$SHELL_DIR" || { echo "切换工作目录失败"; exit 1; }

# ENV
TAG="v9.0.0-beta.3"

# build
echo "开始构建n9e-edge[amd64]镜像..."
sudo docker buildx build \
    --platform linux/amd64,linux/arm64 \
    -t taozig/n9e-edge:latest \
    -t taozig/n9e-edge:"${TAG}" \
    -f ./Dockerfile --no-cache --push ./
