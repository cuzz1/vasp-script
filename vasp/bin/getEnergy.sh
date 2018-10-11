#!/bin/bash

if [ -f energy.txt ]; then
	rm energy.txt
fi

touch energy.txt

for dir in $(ls)
do 

  	if [ -d $dir ]; then
     	cd $dir
		if [ -f OUTCAR ]; then
			flag=`grep reached OUTCAR | tail -n 1 | awk '{print $1 " " $2 " " $3}'`
			#flag=`grep reached OUTCAR | tail -n 1 `
     		E=`cat OUTCAR | grep "energy  without entropy=" | tail -n 1 | awk '{print $4}'` 
			# echo ${flag1}
			echo -e "${dir}\t ${E}\t ${flag}"
			echo  ${dir} ${E} >> ../energy.txt
		fi
     	cd ..
  	fi
  
done
