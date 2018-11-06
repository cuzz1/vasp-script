#!/bin/bash

# by cuzz
# in position or pos folder use this script 

# define contcar folder
folder=contcar

if [ -d $folder ]; then
	rm -rf $folder
fi

mkdir $folder

for dir in $(ls)
do
	if [ -d $dir -a -f $dir/CONTCAR ]; then
		cp $dir/CONTCAR $folder/$dir.vasp
		echo "### cp $dir/CONTCAR $folder/$dir.vasp"
	fi
done



