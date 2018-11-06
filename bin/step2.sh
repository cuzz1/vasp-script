#!/bin/bash
# The second step of structural optimization
# by authors cuzz

# Defing need files
files=(INCAR POTCAR KPOINTS CONTCAR lb.pbs)
# data range
dirs=(0.95 0.96 0.97 0.98 0.99 1.00 1.01 1.02 1.03 1.04 1.05)
#dirs=(0.980 0.985 0.990 0.995 1.000 1.005 1.010 1.015 1.020 1.025)

echo "You shoud in step2 folder."

for file in ${files[*]}
do
	cp ../step1/$file .
	if [ ! -f $file ]; then
		echo -e "\033[31m### Warnning $file NOT FOUND \033[0m"
		exit
	fi	
done


if [ ! -f Poscar ]; then
	echo -e "\033[31m### Warnning Poscar  NOT FOUND \033[0m"
	echo '######################## TIPS #################################'	
	echo -e "\033[32m[1] cp CONTCAR Poscar \033[0m
Fe2B2
   1.00000000000000  \033[32m[2] 使用axx替换坐标\033[0m 
     a11   0.0000000000000000    0.0000000000000000
     0.0000000000000000    a22  0.0000000000000000
     0.0000000000000000    0.0000000000000000   a33
   Fe   B
     8     8
S  \033[32m[3] 把这个加上 \033[0m 
Direct    \033[32m[4] 固定坐标:10,25s/$/ F F F/g\033[0m  
  0.3750000200000017 -0.0000000000000000  0.5878700937855866 F F F
  0.1250000000000000  0.0000000000000000  0.4121299062144134 F F F
  0.8750000200000017 -0.0000000000000000  0.5878700937855866 F F F
  0.6249999799999983 -0.0000000000000000  0.4121299062144134 F F F
"
	exit
fi



# Do you want to run?
echo -e -n "\033[31m### Are you sure to execute this shell [Y/N]: \033[0m"
read flag

if [ ${flag} = "n" -o ${flag} = "N" ]; then
	exit
fi

bakdir=`date +%Y%m%d%H%M%S`
mkdir $bakdir

mv 1.* $bakdir
mv 0.* $bakdir

echo "### Moveing 1.* and 0.* to $bakdir directory"

x11=`cat CONTCAR| sed -n '3p' | awk '{print $1}'`
x22=`cat CONTCAR| sed -n '4p' | awk '{print $2}'`
x33=`cat CONTCAR| sed -n '5p' | awk '{print $3}'`

for dir in ${dirs[*]}
do

	a11=`echo "scale=10;${dir}*${x11}" | bc`
	a22=`echo "scale=10;${dir}*${x22}" | bc`
	a33=`echo "scale=10;${dir}*${x33}" | bc`

	mkdir ${dir}
	echo "### Creating ${dir} directory."
	cp ${files[*]} ${dir}
	cd ${dir}
	cat > POSCAR << EOF
`cat ../Poscar`
EOF
	sed -i "s/a11/${a11}/g" POSCAR
	sed -i "s/a22/${a22}/g" POSCAR
	sed -i "s/a33/${a33}/g" POSCAR
	
	qsub lb.pbs
	cd ..
done




