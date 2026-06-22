#!/bin/bash
SHELL_PATH=$(readlink -f "${BASH_SOURCE[0]}"); SHELL_DIR=$(dirname "$SHELL_PATH"); cd "$SHELL_DIR" || { echo "切换工作目录失败"; exit 1; }


# download jq and tree
sudo apt-get update && sudo apt-get install -y jq tree


# mkdir
mkdir -p "${SHELL_DIR}"/temp/amd64
mkdir -p "${SHELL_DIR}"/temp/arm64


# download file
echo "NowPath=$(pwd) downloadging..."
N9E_TAG=$(curl -s https://api.github.com/repos/ccfos/nightingale/releases/latest | jq -r '.tag_name')
if [ -z "$N9E_TAG" ]; then
  echo "获取最新版本失败"
  exit 1
fi
echo "当前版本: $N9E_TAG"
echo "开始下载 amd64 和 arm64 文件..."
echo "下载 [https://github.com/ccfos/nightingale/releases/download/${N9E_TAG}/n9e-${N9E_TAG}-linux-amd64.tar.gz] 文件..."
wget -q --show-progress -O ./temp/n9e.amd64.tar.gz https://github.com/ccfos/nightingale/releases/download/${N9E_TAG}/n9e-${N9E_TAG}-linux-amd64.tar.gz
echo "下载 [https://github.com/ccfos/nightingale/releases/download/${N9E_TAG}/n9e-${N9E_TAG}-linux-arm64.tar.gz] 文件..."
wget -q --show-progress -O ./temp/n9e.arm64.tar.gz https://github.com/ccfos/nightingale/releases/download/${N9E_TAG}/n9e-${N9E_TAG}-linux-arm64.tar.gz


# 切换工作目录
echo "切换工作目录..."
cd "${SHELL_DIR}"/temp || { echo "切换工作目录失败"; exit 1; }
echo "当前工作目录: $(pwd)"
# 解压下载文件
echo "解压 amd64 文件..."
tar -zxf n9e.amd64.tar.gz -C ./amd64
echo "解压 arm64 文件..."
tar -zxf n9e.arm64.tar.gz -C ./arm64


# done
echo "显示文件结构"
tree "${SHELL_DIR}"/temp -phL 2
echo "done"
