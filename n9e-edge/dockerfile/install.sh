#!/bin/bash
SHELL_PATH=$(readlink -f "${BASH_SOURCE[0]}"); SHELL_DIR=$(dirname $SHELL_PATH); cd "$SHELL_DIR" || { echo "切换工作目录失败"; exit 1; }

# download jq
apt update && apt install -y jq

# download file
echo "downloadging..."
N9E_TAG=$(curl -s https://api.github.com/repos/ccfos/nightingale/releases/latest | jq -r '.tag_name')
echo "N9E_TAG: $N9E_TAG"
wget -O ${SHELL_DIR}/temp/n9e.tar.gz https://github.com/ccfos/nightingale/releases/download/${N9E_TAG}/n9e-${N9E_TAG}-linux-amd64.tar.gz

# switch work directory
echo "switch work directory..."
cd ${SHELL_DIR}/temp/
echo "current work directory: $(pwd)"

# uzip
tar -zxvf n9e.tar.gz

# cp file
echo "cp file..."
cp -f ${SHELL_DIR}/temp/n9e-edge ${SHELL_DIR}/n9e-edge/n9e-edge
cp -f ${SHELL_DIR}/temp/etc/edge/edge.toml ${SHELL_DIR}/n9e-edge/etc/edge.toml

# done
echo "done"