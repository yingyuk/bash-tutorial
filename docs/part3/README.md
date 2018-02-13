# 用户输入

我们通过 `read` 来读取用户输入;

introduction.sh

```bash
#!/bin/bash
# Ask the user for their name

# 提示用户输入
echo Hello, who am I talking to?

# 读取用户输入,并赋值给变量
read varname

# 验证读取命令是否正常工作
# 注意这里的单引号用了反斜杠转义 \'
echo It\'s nice to meet you $varname
```

### 其他读取方式

login.sh

```bash
#!/bin/bash
# Ask the user for login details
read -p 'Username: ' uservar
read -sp 'Password: ' passvar
echo
echo Thankyou $uservar we now have your login details
```

`-p` 是 prompt; 用于指定一个提示输入;

`-s` 是 silent; 用于隐藏用户的输入; 比如隐藏密码输入;

### 多个输入

cars.sh

```bash
#!/bin/bash
# Demonstrate how read actually works

echo What cars do you like?

read car1 car2 car3

echo Your first car was: $car1
echo Your second car was: $car2
echo Your third car was: $car3
```

当时读取多个变量的时候, 你的输入将会以空格切分;
如果输入值少于变量数量; 其他的变量将被设为空;
如果输入值多于变量数量; 剩余的输入将全部添加到最后一个变量;

输入值少与变量数量:

```bash
# 输入值少于变量数量
What cars do you like?

品牌1 品牌2

Your first car was: 品牌1
Your second car was: 品牌2
Your third car was:
```

输入值多于变量数量:

```bash
# 输入值少于变量数量
What cars do you like?

品牌1 品牌2 品牌3 品牌4 品牌5

Your first car was: 品牌1
Your second car was: 品牌2
Your third car was: 品牌3 品牌4 品牌5
```

### 读取标准输入

每一个进程都有它的一组文件:

processID: 进程 ID

* STDIN

  标准输入
  `/proc/<processID>/fd/0`

* STDOUT

  标准输出
  `/proc/<processID>/fd/1`

* STDERR

  标准错误
  `/proc/<processID>/fd/2`

为了更方便的使用它们, 系统提供便捷的方式;

* STDIN - /dev/stdin or /proc/self/fd/0
* STDOUT - /dev/stdout or /proc/self/fd/1
* STDERR - /dev/stderr or /proc/self/fd/2

示例:

数据源 salesdata.txt

```text
Fred apples 20 February 4
Susy oranges 5 February 7
Mark watermelons 12 February 10
Terry peaches 7 February 15
```

Bash 脚本 summary.sh

```bash
#!/bin/bash
# A basic summary of my sales report
echo Here is a summary of the sales data:
echo ====================================
echo
cat /dev/stdin | cut -d' ' -f 2,3 | sort
```

执行

```bash
chmod -R 755 summary.sh
cat salesdata.txt | ./summary.sh

# Here is a summary of the sales data:
# ====================================
# apples 20
# oranges 5
# peaches 7
# watermelons 12
```

`cat /dev/stdin` 是打印标准输出;

`|` 是管道, 将刚刚的输出作为下一个命令的输入

`cut -d ' '` 是将输入数据以空格分割开来; `-d` delimiter 分隔符;

`cut -d ' ' -f 2,3` 是取出切割后的第 2,3 行的数据; `-f` fields;

`| sort` 对第 2,3 行数据进行从大到小排序; 注意是一行行的排序下去, 先排前面的, 示例中先对水果名称进行排序, 再对水果数量进行排序;
