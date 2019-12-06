#!/bin/bash

if [[ $# != 1 ]]; then
	echo "Please enter Vasp script.(xx.vasp)"
	exit
fi


project_path=$(pwd)
project_name="${project_path##*/}"

vasp=${project_name}"_"$1
echo $vasp

cp $1 $vasp 

qsub $vasp
