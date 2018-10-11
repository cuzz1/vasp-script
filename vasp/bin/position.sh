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


# Do you want to run?
echo -e -n "\033[31m### Are you sure to execute this shell [Y/N]: \033[0m"
read flag

if [ ${flag} = "n" -o ${flag} = "N" ]; then
    exit
fi


files=$(ls $folder)
for file in $files
do
	if [ -d $file ]; then
		rm -rf $file
		echo "### Deleted $file folder."
	fi
	mkdir $file
	echo "### Creating $file folder."
	cp $folder/$file  $file/
	cp ${list[*]} $file/
	cd $file && mv $file POSCAR 
	qsub lb.vasp
	cd ..
done