# Shell

## Shell编程之Hello World

编写一个hello world

shell一般使用`.sh`作为后缀

```shell
#!/bin/bash                  # 使用/bin/sh来解释执行
 
# auto ehco hello world!     # 解释这个脚本是干什么的
# by authors cuzz 			# 作者和时间一些信息

echo "hello world!"              
```

给脚本添加执行权限

```
> chmod +x hello.sh
```

## Shell编程之变量

Shell变量可以分为两类：局部变量和环境变量

```shell
#!/bin/bash

# define path variables
# by authors cuzz

name=cuzz    # 等号两边不能有空格

echo "my name is $name"  # 使用$引用
```

基本变量

```shell
echo $PWD  # 当前路径
echo $0    # 脚本名
echo $1    # 第一个参数
echo $2    # 第二个参数
echo $?    # 判断上一个命令是否正确
echo $*    # 所有参数
echo $#    # 参数的个数
```

## Shell编程之if条件语句

比较大小

```shell
#!/bin/bash

# if test
# by authors cuzz

num=100

# 计算使用两个小括号
if (($num > 10)); then
    echo "this num greater than 10."
else
    echo "this num littler than 10."
fi
```

逻辑运算符

| 运算符 | 说明                                                  | 举例                          |
| :----: | ----------------------------------------------------- | :---------------------------- |
|  -eq   | 检测两个数是否相等，相等返回   true。                 | [   \$a -eq $b ] 返回 false。 |
|  -ne   | 检测两个数是否不相等，不相等返回 true。               | [ \$a -ne $b ] 返回 true。    |
|  -gt   | 检测左边的数是否大于右边的，如果是，则返回 true。     | [ \$a -gt $b ] 返回 false。   |
|  -lt   | 检测左边的数是否小于右边的，如果是，则返回 true。     | [ \$a -lt $b ] 返回 true。    |
|  -ge   | 检测左边的数是否大于等于右边的，如果是，则返回 true。 | [ \$a -ge $b ] 返回 false。   |
|  -le   | 检测左边的数是否小于等于右边的，如果是，则返回 true。 | [ \$a -le $b ] 返回 true。    |

目录

| 操作符  | 说明                                                         | 举例                      |
| ------- | ------------------------------------------------------------ | ------------------------- |
| -d file | 检测文件是否是目录，如果是，则返回 true。                    | [ -d $file ] 返回 false。 |
| -f file | 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。 | [ -f $file ] 返回 true。  |
| -p file | 检测文件是否是有名管道，如果是，则返回 true。                | [ -p $file ] 返回 false。 |
| -e file | 检测文件（包括目录）是否存在，如果是，则返回 true。          | [ -e $file ] 返回 true。  |

创建文件

```shell
#!/bin/bash

# if test
# by authors cuzz

DIR=cuzz

if [ ! -d $DIR ]; then  # 都有空格
    mkdir $DIR
    echo "this $DIR create success."
else
    echo "this dir is exit."
fi
```

测试文件是否存在

```shell
#!/bin/bash

# if test
# by authors cuzz

file=test.txt

if [ ! -e $file ]; then  
    echo "OK" >> $file  # >>是追加内容 >是覆盖内容
else
    cat $file
fi
```

mysql备份

```shell
#!/bin/bash

# auto backup mysql db
# by authors cuzz

# define backup path
BAK_DIR=/data/backup/`date +%Y%m%d` # 反引号可以把里面当作命令来解析 
# mysql
MYSQLDB=test
MYSQLUSER=root
MYSQLPW=123456
MYSQLCMD=/usr/bin/mysqldump # 备份命令

# 判断是否是root
if [ $UID -ne 0 ]; then
    echo "Only root can execute Shell."
    exit
fi


if [ ! -d $BAK_DIR ]; then
    mkdir -p $BAK_DIR      # -p 父目录不存在就创建
    echo "The $BAK_DIR create success."
else
    echo "This $BAK_DIR is exist."
fi



# mysql backup command
$MYSQLCMD -u$MYSQLUSER -p$MYSQLPW -d $MYSQLDB >$BAK_DIR/$MYSQLDB.sql

if [ $? -eq 0 ]; then
    echo "backup success."
else
    echo "backup fail."
fi
```

## Shell编程之for循环

基本语句

```shell
#!/bin/bash

for i in `seq 1 15`
do
    echo "the number is $i."
done
```

求和

```shell
#!/bin/bash

sum=0

for ((i=1; i<=100; i++)) # 双括号用于运算相当与其他语言的单括号
do
    sum=`expr $sum + $i` # expr用于计算
done

echo "$sum"

```

打包，只能打包到最后一个，后面的会把前面的覆盖了

```shell
#!/bin/bash

for file in `find ./ -name "*.sh"`

do
    tar -czf all.tgz $file
done

```

## Shell编程之while循环

使用

```shell
#!/bin/bash

i=0
while [[ $i -lt 10 ]]  # (( $i < 10))是一样的
do
    echo "$i"
    ((i++))
done
```

结合read使用

```shell
#!/bin/bash

while read line   # 把读取的东西赋值给line
do
    echo $line
done </etc/hosts  # 从哪里读取

```

## Shell编程之数组

Shell 数组用括号来表示，元素用"空格"符号分割开，语法格式如下：

 ```shell
my_array=(A B "C" D) # 定义数组

array_name[0]=value0 # 使用下标来定义
array_name[1]=value1
array_name[2]=value2

${array_name[0]}	 # 读取第一个元素

${my_array[*]}		 # 读取所有元素	
${my_array[@]}		 # 读取所有元素

${#my_array[*]} 	 # 读取数组长度
${#my_array[@]}		 # 读取数组长度
 ```

## Shell编程之函数

无返回值得函数

```shell
sayHello(){                  # 定义函数一
    echo "hello"
}

function sayHelloWorld(){    # 定义函数二
    echo "hello world"
}
sayhell  # 使用函数
```

有返回值得，使用return只能返回0-255

```shell
function sum()
{
  returnValue=$(( $1 + $2 ))
  return $returnValue
}

sum 22 4

echo $?
```

可以使用echo来传递参数 

```shell
function length()
{
  str=$1
  result=0
  if [ "$str" != "" ] ; then
      result=${#str}
  fi
  echo "$result"
}

len=$(length "abc123")  # 调用

echo "The string's length is $len "
```



## Shell编程之sed命令

把test.txt中的old修改为new，要使用-i才能插入

```
> sed -i 's/old/new/s' test.txt
```

在每行行前面添加一个cuzz

```
> sed -i  sed 's/^/&cuzz/g' test.txt
```

在每行的末尾添加一个cuzz

```
> sed  -i 's/$/& cuzz/g' test.txt
```

匹配某一行，在下方插入一行，找到cuzz这行在下方插入####

```
> sed '/cuzz/a #######' test.txt
```

在之前添加一行，只要把a改成i

```
> sed '/cuzz/i #######' test.txt
```

打印

```
> sed -n '/cuzz/p' test.txt  # 打印含有cuzz这一行
> sed -n '1p' test.txt       # 打印第一行
> sed -n '1,5p' text.txt     # 打印1到5行
```

查找最大和最小值 number.txt

```
12 324 56 0034 -23 345
345 349- 245 345 

345 0989 0459 -25
```

命令

```shell
cat number.txt | sed 's/ /\n/g' | grep -v "^$" | sort -nr | sed -n '1p;$p'

sed 's/ /\n/g'  # 把所有空格换成换行
grep -v "^$"    # 去掉所有空格
sort -nr        # 降序排列
sed -n '1p;$p   # 找出第1行和最后一行
```



## Shell编程之grep命令

> -a ：将 binary 文件以 text 文件的方式搜寻数据
>
> -c ：计算找到 '搜寻字符串' 的次数
>
> -i ：忽略大小写的不同，所以大小写视为相同
>
> -n ：顺便输出行号
>
> -v ：反向选择，亦即显示出没有 '搜寻字符串' 内容的那一行
>
> --color=auto ：可以将找到的关键词部分加上颜色的显示

egrep 和grep -E 相同，可以使用正则表达式

## Shell编程之awk命令

```shell
# 每行按空格或TAB分割
cat test.txt | awk '{print $1}'      # 行匹配语句 awk '' 只能用单引号

# 指定分割
awk -F                               #-F相当于内置变量FS, 指定分割字符
cat test.txt | awk -F: '{print $1}'  # 以分号分割

# 指定添加某些内容
cat test.txt | awk -F: '{print "haha" $1}' # 提前出来再添加haha
```

## Shell编程之find命令

基本命令

```shell
find /dir -name "test.txt"          # 在/dir目录下查找
find . -name "test.txt"             # 在当前目录下找 
find . -maxdepth 1 -name "text.txt" # 只遍历一层
find . -type f -name "text"         # 指定类型
find . -name "text" -mtime -1       # 指定时间
find . -size +20M                   # 指定大小
```

查找并执行其他命令

```shell
find . -name "text.txt" -exec rm -rf {} \;  # 后面{} \是固定格式
```



 

 

 

 