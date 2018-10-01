# Shell

## 笔记

[Shell编程笔记](/notes/Shell.md)

## VASP脚本

自己整理的一些vasp脚本

添加环境变量

```
# 进入当前目录
> cd ~
# 添加环境
> vi .bash_profile
# bin目录, 使用pwd查看目录,追加到后面
export LB_HOME=/home/vasp/user/libing
export PATH=$PATH:$LB_HOME/bin
# 更新
> source .bash_profile
```
