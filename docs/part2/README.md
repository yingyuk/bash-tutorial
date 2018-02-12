# 变量

变量的读取与设置

当读一个变量时, 我们放一个`$`符号在变量前;
但设置变量值时, 我们要去掉`$`符号.

变量可以是全大写,全小写,驼峰, 看个人喜好.
变量可以在脚本的任何地方定义, 当运行时, Bash 脚本会先替换变量值, 再运行脚本命令.

## 命令行变量

```bash
#!/bin/bash
# mycopy.sh

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
```

### 其他特别的变量

* `$0` : Bash 脚本的名字.
* `$1 - $9` : Bash 脚本的前九个参数
* `$#` : 有多少个参数传递给了 Bash 脚本
* `$@` : Bash 脚本的所有参数
* `$?` : 最近运行的进程的退出状态。
* `$$` : 当前脚本的进程 ID
* `$USER` : 运行脚本的用户的用户名
* `$HOSTNAME` : 运行脚本的机器的主机名
* `$SECONDS` : 自脚本启动以来的秒数
* `$RANDOM` : 每次返回一个不同的随机数
* `$LINENO` : 返回 bash 脚本中的当前行号。

如果在命令行中输入 `env`, 你会看到一个变量列表, 这些变量也可以在脚本中被使用

### 设置我们的变量

```bash
#!/bin/bash
# variables.sh
name=张三
age=18

echo 你好, 我是$name
echo
echo 今年$age 岁了
# 你好, 我是张三
#
# 今年18 岁了
```

`=` 等于号旁边没有空格,在设置变量名的时候,并没有`$`符号;

设置了两个值, name 和 age;
用 `echo` 打印输出; 检测变量已经被设值了;
同时用 `echo` 不传入任何参数;用来换行;

```bash
#!/bin/bash
myvar=Hello World
# -bash: World: command not found
newvar='Hello World'
```

当我们设置一个比较复杂的变量时, 我们需要使用引号;因为 Bash 脚本通过空格来区分一个元素;

* 单引号包含的内容表示一个字符串

* 双引号包含的内容可以进行变量替换

```bash
#!/bin/bash
# quotes.sh
myvar='Hello World'
echo $myvar
# Hello World

newvar="More $myvar"
echo $newvar
# More Hello World

newvar='More $myvar'
echo $newvar
# More $myvar
```

### 命令替换

命令替换允许我们获取命令或程序的输出（通常会打印到屏幕上）并将其保存为变量的值;
要做到这一点，我们把它放在括号内，前面有一个$符号。

```bash
#!/bin/bash

myvar=$( ls /etc | wc -l )
echo 有 $myvar 个条目在 /etc 文件夹内
# 有 88 个条目在 /etc 文件夹内
```

`wc` Word Count; 一个查看单词数量的命令

```bash
# 查看行数
wc -l
# wc --lines

# 查看单词数量
wc -w
# wc --words

# 查看字节数
wc -c
# wc --chars
```

### 变量导出

script1.sh

```bash
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
```

script2.sh

```bash
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
```

最终输出

```text
script1.sh :: var1 : blah, var2 : foo
./script2.sh :: var1 : blah, var2 :
./script2.sh :: var1 : flop, var2 : bleh
script1.sh :: var1 : blah, var2 : foo
```

Bash 脚本导出变量时, 其实是创建一个新的进程,然后复制变量并把它交给新的进程;
所以尽管这些变量具有相同的名称, 但他们存在不同的进程中,彼此并不相关;

导出变量时一个单向过程, 原始进程将变量传递给新进程, 但任何进程对变量的任何操作都不会影响原始变量;
