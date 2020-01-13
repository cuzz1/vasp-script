#!/bin/bash
mkdir dos
cp CONTCAR dos/POSCAR
cd dos
potcar.sh
kpoints.sh 11 11 1


