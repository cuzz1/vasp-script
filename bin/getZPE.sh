#!/bin/bash

# by authors cuzz

for dir in $(ls)
do 
	if [ -d $dir/freq ]; then
		cd $dir/freq
		echo -e "$dir\t\c"
		ZPE.exe
		cd ../../
	fi
done
