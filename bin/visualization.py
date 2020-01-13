#!/home/lineng/software/python36/bin/python3.6


# https://wiki.fysik.dtu.dk/ase/ase/visualize/visualize.html

from ase.io import write
from ase.io import read
from ase.calculators.vasp import Vasp
from ase import Atoms
import matplotlib.pyplot as plt
from ase.visualize.plot import plot_atoms

slab = read("./CONTCAR")


#write("image.png", atoms, rotation="10z,-80x")
#write("0.pov", atoms,format="pov", ,run_povray=True,rotation="10z,-80x")
fig, axarr = plt.subplots(1, 4, figsize=(15, 5))
plot_atoms(slab, axarr[0], radii=0.3, rotation=('0x,0y,0z'))
plot_atoms(slab, axarr[1], scale=0.7, offset=(3, 4), radii=0.3, rotation=('0x,0y,0z'))
plot_atoms(slab, axarr[2], radii=0.3, rotation=('45x,45y,0z'))
plot_atoms(slab, axarr[3], radii=0.3, rotation=('0x,0y,0z'))
#write('slab.png',slab, rotation='10z,-80x')
fig.savefig("ase_slab_multiple.png")


