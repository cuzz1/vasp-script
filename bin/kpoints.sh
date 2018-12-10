#! /bin/bash

# To generate KPINTS file
# To use it: kpoints.sh 3 3 1
# Default 4 4 1
a=4
b=4
c=1

echo K-POINTS > KPOINTS
echo 0 >> KPOINTS
echo Gamma-Centered >> KPOINTS
if [[ $# != 3 ]]; then
	echo $a $b $c  >> KPOINTS
else
	echo $1 $2 $3 >> KPOINTS
fi
echo 0 0 0 >> KPOINTS
cat KPOINTS
