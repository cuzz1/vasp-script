#!/bin/bash

# Create POSTCAR
# To use it: postcar.sh Fe B O H
# OR postcar.sh Without parameters, it will be automatically extracted from POSCAR

# Define local potpaw_GGA pseduopotential repository:
#repo="/home/lineng/vasp/user/libing/VASP/potpaw_PBE1"

# 查找脚本的目录
repo=${LB_HOME}"/pbe"
#echo $repo

if [ -f POSCAR ]; then
	str=`sed -n '6,1p' POSCAR | tr '\r' ' ' | tr '\n' ' '`
fi 

if [ -d poscar ]; then
	filelist=`ls poscar/`
	for file in $filelist
	do
		str=`sed -n '6,1p' poscar/$file | tr '\r' ' ' | tr '\n' ' '`
		break
	done
fi

if (( $# == 0)); then
	arr=($str)
else
	arr=$*
fi

# Check if older version of POTCAR is present
if [ -f POTCAR ] ; then
	mv -f POTCAR old-POTCAR
	# echo "### WARING: old POSTCAR file found and renamed to 'old-POTCAR'."
fi

# Main loop - concatenate the appropriatePOTCARs (or archives)
for i in ${arr[*]};
do
 	if test -f $repo/$i/POTCAR ; then
		cat $repo/$i/POTCAR>> POTCAR
 	elif test -f $repo/$i/POTCAR.Z ; then
		zcat $repo/$i/POTCAR.Z >> POTCAR
	elif test -f $repo/$i/POTCAR.gz ; then
		gunzip -c $repo/$i/POTCAR.gz >> POTCAR
	else
		echo "### WARING: No suitable POTCAR for element $i !!! Skipped this element."
 	fi
done

grep "TITEL" POTCAR
