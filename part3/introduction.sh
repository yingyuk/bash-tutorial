#!/bin/bash
# Ask the user for their name

# 提示用户输入
echo Hello, who am I talking to?

# 读取用户输入,并赋值给变量
read varname

# 验证读取命令是否正常工作
# 注意这里的单引号用了反斜杠转义 \'
echo It\'s nice to meet you $varname
