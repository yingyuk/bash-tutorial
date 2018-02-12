#!/bin/bash

# demonstrate variable scope 1.
# script1 内定义变量
var1=blah
var2=foo
# Let's verify their current value
# 查看当前值
echo $0 :: var1 : $var1, var2 : $var2
# 导出 var1, 给其他脚本使用
export var1
# 执行其他脚本
./script2.sh
# Let's see what they are now

# 查看 script1 的变量是否被其他脚本改变
echo $0 :: var1 : $var1, var2 : $var2
