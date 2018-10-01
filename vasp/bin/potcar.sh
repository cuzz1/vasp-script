#! /bin/bash

# Create POSTCAR
# To use it: postcar.sh Fe B O H

# Define local potpaw_GGA pseduopotential repository:

#repo="/home/lineng/vasp/user/libing/VASP/potpaw_PBE1"

# 查找脚本的目录
repo=${LB_HOME}"/PBE"
# echo $repo

# Check if older version of POTCAR is present
if [ -f POTCAR ] ; then
	mv -f POTCAR old-POTCAR
	echo "### WARING: old POSTCAR file found and renamed to 'old-POTCAR'."
fi

# Main loop - concatenate the appropriatePOTCARs (or archives)
for i in $*
do
 	if test -f $repo/$i/POTCAR ; then
		cat $repo/$i/POTCAR>> POTCAR
 	elif test -f $repo/$i/POTCAR.Z ; then
		zcat $repo/$i/POTCAR.Z >> POTCAR
	elif test -f $repo/$i/POTCAR.gz ; then
		gunzip -c $repo/$i/POTCAR.gz >> POTCAR
	else
		echo "### WARING: No suitable POTCAR for element '$i' found!! Skipped thiselement."
 	fi
done

grep "TITEL" POTCAR
