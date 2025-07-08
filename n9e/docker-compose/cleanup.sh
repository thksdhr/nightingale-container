#!/bin/bash
SHELL_PATH=$(readlink -f "${BASH_SOURCE[0]}"); SHELL_DIR=$(dirname $SHELL_PATH); cd "$SHELL_DIR" || { echo "切换工作目录失败"; exit 1; }

#!/bin/bash

echo -n "是否确定清理全部数据 (y/n): "
read -rn 1 input
echo


if [[ $input == "y" || $input == "Y" ]]; then
    echo "你选择了继续清理~"
elif [[ $input == "n" || $input == "N" ]]; then
    echo "不清理，退出程序"
    exit 1
else
    echo "无效的输入"
    exit 1
fi


rm -rf ./volumes/postgres/data
rm -rf ./volumes/mysql/data
rm -rf ./volumes/victoriametrics

echo "清理完成"