#!/bin/bash

# authors by cuzz

list=(INCAR CONTCAR POTCAR KPOINTS lb.pbs)
folder=freq

for item  in ${list[*]}
do
    if [ ! -f $item ]; then
        echo -e "\033[31m### Warnning $item NOT FOUND \033[0m"
        exit
    fi
done


mkdir $folder

#echo "${list[*]}"
#echo "$folder"

cp ${list[*]}  $folder/

cd $folder
mv INCAR INCAR.x
mv CONTCAR POSCAR.x

echo "### 1. INCAR.	 Frequency "
echo "### 2. POSCAR. Seletivity"
echo "### 3. POSCAR. Fix Atmo,  10,25s/$/ F F F/g"



