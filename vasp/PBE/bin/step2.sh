#!/bin/bash

if [ ! -f INCAR ]; then
	echo "INCAR NOT FOUND"
elif [ ! -f POTCAR ]; then
	echo "POTCAR NOT FOUND"
elif [ ! -f KPOINTS ]; then
	echo "KPOINTS NOT FOUND"
elif [ ! -f vasp.pbs ]; then
	echo "vasp.pbs NOT FOUND"
else

	echo -n "are you sure? (y/n)"
	read flag

	if [ ${flag} != "y" ]; then
		return	
	fi

	for dir in 0.95 0.96 0.97 0.98 0.99 1.00 1.01 1.02 1.03 1.04 1.05 
	do
		a=`echo "scale=10;${dir}*5.78499984740000000" | bc`
		b=`echo "scale=10;${dir}*5.65549993519999999" | bc`
		c=`echo "scale=10;${dir}*13.8599996566999994" | bc`

		if [ -d ${dir} ]; then
			rm -rf ${dir}
			echo "deleting ${dir}"
		fi
		mkdir ${dir}
		cp INCAR POTCAR KPOINTS vasp.pbs ${dir}
		cd ${dir}

		cat > POSCAR << EOF
hollow                                  
   1.00000000000000     
     ${a}    0.0000000000000000    0.0000000000000000
     0.0000000000000000    ${b}    0.0000000000000000
     0.0000000000000000    0.0000000000000000  ${c} 
   O    Fe   B 
     8     8     8
S
Direct
  0.1253769034615188 -0.0000787035122891  0.6030818460702833 F F F
  0.3749169713247500 -0.0005587870248845  0.3901786375343830 F F F
  0.6253769034615189 -0.0000787035122891  0.6030818460702833 F F F
  0.8749169713247503 -0.0005587870248845  0.3901786375343830 F F F
  0.1253769034615188  0.4999212964877109  0.6030818460702833 F F F
  0.3749169713247500  0.4994412129751156  0.3901786375343830 F F F
  0.6253769034615189  0.4999212964877109  0.6030818460702833 F F F
  0.8749169713247503  0.4994412129751156  0.3901786375343830 F F F
  0.1251571830119715  0.2496032002936812  0.4682870624061856 F F F
  0.3752173934452896  0.2497620693171136  0.5249870196815317 F F F
  0.6251571830119717  0.2496032002936812  0.4682870624061856 F F F
  0.8752173934452898  0.2497620693171136  0.5249870196815317 F F F
  0.1251571830119715  0.7496031792936831  0.4682870624061856 F F F
  0.3752173934452896  0.7497620483171153  0.5249870196815317 F F F
  0.6251571830119717  0.7496031792936831  0.4682870624061856 F F F
  0.8752173934452898  0.7497620483171153  0.5249870196815317 F F F
  0.3754365433928653  0.2499644634157319  0.6357249244589221 F F F
  0.1248450013636074  0.2494177565106473  0.3575705728486884 F F F
  0.8754365433928651  0.2499644634157319  0.6357249244589221 F F F
  0.6248449703636011  0.2494177565106473  0.3575705728486884 F F F
  0.3754365433928653  0.7499644424157336  0.6357249244589221 F F F
  0.1248450013636074  0.7494177565106470  0.3575705728486884 F F F
  0.8754365433928651  0.7499644424157336  0.6357249244589221 F F F
  0.6248449703636011  0.7494177565106470  0.3575705728486884 F F F
EOF
		qsub vasp.pbs
		cd ..
	done
fi