#!/bin/bash

# cuzz

# How to use, 'fix.sh N H', Means not fixed N and H atom.
# Notice, must make unfixed atoms at the end.
#
# In POSCAR or CONTCAR just like,
#
# Fe B O N H
# 8  8 8 2 6 
# you can use 'fix.sh N H' is ok.
#
# but, 
# Fe B  H O
# 8  8  8 8
# you can't use 'fix.sh H', because H is not at the end.


fileName=CONTCAR

str1=`sed -n "6p" $fileName`
str2=`sed -n "7p" $fileName`

# covert to array
arr1=($str1) 
arr2=($str2)

# get array length
len=${#arr1[@]}

# unfix atoms array
arr3=$*

# total atoms count
total=0

# unfixed atoms count
unfixed=0

for ((i=0; i<${len}; i++))
do
	((total=$total+${arr2[$i]}))
	for e in ${arr3}
	do 
		if [ "${arr1[$i]}" == "${e}" ]; then
			((unfixed=$unfixed+${arr2[$i]}))
		fi
	done
done

sed -i "7a S" $fileName

((fixed=$total-$unfixed))

((n1=$fixed-1+10))

((n2=$n1+1))

((n3=$n2+$unfixed-1))

sed -i "10,${n1}s/$/ F F F/g" $fileName
sed -i "${n2},${n3}s/$/ T T T/g" $fileName

cat $fileName
