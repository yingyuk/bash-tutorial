#!/bin/bash

# 简单的复制脚本
cp $1 $2
# ./mycopy.sh ./src/file1 ./dist/file2
# $1 是命令后的第一个参数, ./src/file1
# $2 是命令后的第二个参数, ./dist/file2

# 验证复制是否成功
echo $2 的详情如下:
ls -lh $2
# ./dist/file2 的详情如下:
# -rw-r--r--  1 yingyuwu  staff     5B Dec 26 23:27 ./dist/file2
