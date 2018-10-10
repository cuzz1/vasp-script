#!/bin/bash

# authors by cuzz

# position folder contains postar folder(top hollow..)
# and other files(list)


folder=postar
list=(INCAR POTCAR KPOINTS lb.pbs)

for item  in ${list[*]}
do
    if [ ! -f $item ]; then
        echo -e "\033[31m### Warnning $item NOT FOUND \033[0m"
        exit
    fi
done



if [ ! -d $folder ]; then
	echo -e "\033[31m### Warnning $folder FOLDER NOT FOUND \033[0m"
	exit
fi 

files=$(ls $folder)
for file in $files
do
	mkdir $file
	echo "### Creating $file folder."
	cp $folder/$file  $file/
	cd $file && mv $file POSCAR && cd ..
	cp ${list[*]} $file/
done

