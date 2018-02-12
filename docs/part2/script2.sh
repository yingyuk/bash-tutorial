#!/bin/bash

# demonstrate variable scope 2
# Let's verify their current value
# 查看变量
echo $0 :: var1 : $var1, var2 : $var2

# 改变变量值
var1=flop
var2=bleh

# 查看变量值
echo $0 :: var1 : $var1, var2 : $var2
