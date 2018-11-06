# VASP脚本

自己整理的一些vasp脚本

添加环境变量

```
# 进入当前目录
> cd ~
# 添加环境
> vi .bash_profile
# bin目录, 使用pwd查看目录,追加到后面
export LB_HOME=/home/lineng/vasp/user/libing/vasp-script
export PATH=$PATH:$LB_HOME/bin
# 更新
> source .bash_profile
# 添加执行权
> cd $LB_HOME/bin
> chmod +x *
```
