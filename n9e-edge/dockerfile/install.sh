#!/bin/bash
SHELL_PATH=$(readlink -f "${BASH_SOURCE[0]}"); SHELL_DIR=$(dirname $SHELL_PATH); cd "$SHELL_DIR" || { echo "切换工作目录失败"; exit 1; }

# download jq
apt update && apt install -y jq

# mkdir
mkdir -p ${SHELL_DIR}/temp
mkdir -p ${SHELL_DIR}/n9e-edge/etc

# download file
echo "NowPath=$(pwd) downloadging..."
N9E_TAG=$(curl -s https://api.github.com/repos/ccfos/nightingale/releases/latest | jq -r '.tag_name')
if [ -z "$N9E_TAG" ]; then
  echo "获取最新版本失败"
  exit 1
fi
echo "N9E_TAG: $N9E_TAG"
wget -O ./temp/n9e.tar.gz https://github.com/ccfos/nightingale/releases/download/${N9E_TAG}/n9e-${N9E_TAG}-linux-amd64.tar.gz

# switch work directory
echo "switch work directory..."
cd ${SHELL_DIR}/temp || { echo "切换工作目录失败"; exit 1; }
echo "current work directory: $(pwd)"
# uzip
tar -zxvf n9e.tar.gz

# cp file
echo "switch work directory..."
echo "NowPath=$(pwd) cp file..."
cp -f ${SHELL_DIR}/temp/n9e-edge ${SHELL_DIR}/n9e-edge/n9e-edge
cp -f ${SHELL_DIR}/temp/etc/edge/edge.toml ${SHELL_DIR}/n9e-edge/etc/edge.toml

# done
echo "Display Files"
ls -alh ${SHELL_DIR}/n9e-edge
ls -alh ${SHELL_DIR}/n9e-edge/etc
echo "done"
