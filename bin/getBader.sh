#! /bin/bash
# get bader file

chgsum.pl AECCAR0 AECCAR2
bader CHGCAR -ref CHGCAR_sum
