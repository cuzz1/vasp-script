#!/bin/bash

mkdir o
cp s/INCAR o/
cp s/KPOINTS o/
cp s/POSCAR o/
cp s/lb.pbs o/
cd o

dos2unix *


sed -i '65,66d' POSCAR

n1=`sed -n '6p' POSCAR`
n2=`sed -n '7p' POSCAR`

# 删除最后字符串
n11=`echo ${n1:0:-2}`
n22=`echo ${n2:0:-2}`

echo $n11
echo $n22

sed -i "6c $n11" POSCAR
sed -i "7c $n22" POSCAR

cat POSCAR

potcar.sh




