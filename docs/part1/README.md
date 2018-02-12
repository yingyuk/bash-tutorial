# 介绍 Bash 脚本

Bash 脚本是一个包含一系列命令的纯文本文件。

任何可以在命令行上正常运行的东西都可以放到脚本中，同样的，任何你可以放入脚本的东西也可以在命令行上正常运行。并且完全一样。

## 创建并执行脚本

```sh
# 创建编写脚本
tee ./myscript.sh <<-'EOF'
#!/bin/bash
# 这是一条注释

echo Hello World!
EOF

# 执行脚本 (没有执行权限)
./myscript.sh # -bash: ./myscript.sh: Permission denied

# 查看脚本权限
ls -l myscript.sh
# -rw-r--r--  1 yingyuwu  staff  17 Dec 25 22:17 myscript.sh

# 修改脚本权限
chmod 755 myscript.sh

# 验证是否修改成功
ls -l myscript.sh
# -rwxr-xr-x  1 yingyuwu  staff  17 Dec 25 22:17 myscript.sh

# 再次执行脚本
./myscript.sh
# Hello World
```

备注:

1. 权限 755 通常用于脚本, 因为它允许所有者编写或修改脚本，并让所有人执行脚本。读、写、运行三项权限可以用数字表示，就是 r=4,w=2,x=1。[read, write, execute]
1. `#`号以后的所有文本都不会执行, 用于注释

### 为什么加 `./`

当我们执行其他命令 比如 `ls` 时, 我们只需要输入它们的名字;
在命令行中输入命令时, Bash 会在它的 `$PATH`中去查找是否有这个命令;
而 myscript.sh 加上了 `./` 是为了指定脚本路径;

```sh
echo $PATH
/Users/yingyuwu/.nvm/versions/node/v8.9.1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# /Users/yingyuwu/.nvm/versions/node/v8.9.1/bin
# :/usr/local/bin
# :/usr/bin
# :/bin
# :/usr/sbin
# :/sbin
```

### `#!` shebang

`#!/bin/bash` 是指此脚本使用`/bin/bash` 来解释执行，`#!`是特殊的表示符，其后面根的是此解释此脚本的 shell 的路径。格式在这里很重要。

shebang 必须在文件的第一行（即使第一行是空白，第二行也不行）。在这之前还必须没有空格。

当没有 `#!/bin/bash` 这一行, 也是可以运行脚本的;
但这是不明智的。如果你在一个终端上运行 Bash shell，并且执行一个没有 shebang 的脚本，那么 Bash 会认为它是一个 Bash 脚本;
然而有很多情况下, 文件并不一定是 bash 脚本, 没有 shebang 就会被 Bash shell 运行, 这会带来隐患。
