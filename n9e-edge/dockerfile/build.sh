#!/bin/bash
SHELL_PATH=$(readlink -f "${BASH_SOURCE[0]}")
echo "SHELL_PATH=[$SHELL_PATH]"
SHELL_DIR=$(dirname $SHELL_PATH)
echo "SHELL_DIR=[$SHELL_DIR]"
cd "$SHELL_DIR" || { echo "切换工作目录失败"; exit 1; }

echo "开始构建n9e-edge镜像..."
docker build -t taozig/n9e-edge:latest -f ./dockerfile --no-cache --pull ./

echo "镜像构建完成，开始推送到Docker Hub..."
docker push taozig/n9e-edge:latest

echo "保存镜像到本地文件..."
docker save taozig/n9e-edge:latest -o n9e-edge.tar