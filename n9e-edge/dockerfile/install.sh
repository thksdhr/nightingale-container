#!/bin/bash
SHELL_PATH=$(readlink -f "${BASH_SOURCE[0]}"); SHELL_DIR=$(dirname $SHELL_PATH); cd "$SHELL_DIR" || { echo "切换工作目录失败"; exit 1; }