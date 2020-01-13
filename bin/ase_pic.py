#!/home/lineng/software/python36/bin/python3.6

import os
import sys
from glob import glob
from ase.io import read, write
from ase import Atoms
import numpy as np
from ase.utils import natural_cutoffs
from ase.build import molecule
import matplotlib.pyplot as plt
import sys
arg=sys.argv[1]
fz=read(arg)
x=fz.get_number_of_atoms()
#text=['intermediate',]*x
text=['vmd',]*x
b=[0 for i in range(x)]
c=[]
i=0
for atom in fz:
    if atom.symbol == "Co":
        b[i]=0.7
       # green=(240/255,98/255,146/255)
        green=(244/255,143/255,177/255)
        c.append(green)
    elif atom.symbol == "Au":
        b[i]=0.7
    elif atom.symbol == "C":
        b[i]=0.5
       # black=(128/255,128/255,128/255)
        black=(158/255,158/255,158/255)
        c.append(black)
    elif atom.symbol == "N":
        b[i]=0.5
        colorN=(150/255,100/255,78/255)
        c.append(colorN)
    elif atom.symbol == "B":
        b[i]=0.5
        colorB=(10/255,50/255,78/255)
        c.append(colorB)
    elif atom.symbol == "O":
        b[i]=0.5
        red=(255/255,0/255,0/255)
        c.append(red)
    elif atom.symbol == "H":
        b[i]=0.4
      #white=(245/255,245/255,245/255)
        white=(255/255,255/255,255/255)
        c.append(white)
    elif atom.symbol == "Fe":
        b[i]=0.7
        orange=(255/255,127/255,80/255)
        c.append(orange)
    elif atom.symbol == "Mo":
        b[i]=0.70
        cyan=(0/255,151/255,167/255)
        c.append(cyan)
    else:
        b[i]=0.7
       # blue=(0/255,20/255,255/255)
        blue=(30/255,136/255,229/255)
        c.append(blue)
    i=i+1
print (c)
def attachbonds(atoms):
    bondatoms = []
    symbols = atoms.get_chemical_symbols()
    cutoffs = np.array(natural_cutoffs(atoms))+0.15
    num = len(symbols)
    for i in range(num):
        for j in range(i):
            ni = cutoffs[i]
            nj = cutoffs[j]
            disij = atoms.get_distance(i, j)

            band_list  = ["N", "C","H","O","S", "B", "P"]
            if (atoms.symbols[i] in band_list): #and atoms.symbols[j]!="Co":
                if ni + nj > disij + 0.15:
                    bondatoms.append((i, j))
    return bondatoms


#rot = '-90.73x,11.833y,0.117293z'  # found using ag: 'view -> rotate'
#rot = '0x,0y,0z'  # found using ag: 'view -> rotate'
kwargs = {
    # 'rotation'      : rot , # text string with rotation (default='' )
   "radii": b,  # float, or a list with one float per atom
    #'colors': ,  # List: one (r, g, b) tuple per atom
    'show_unit_cell': 0,   # 0, 1, or 2 to not show, show, and show all of cell
}

kwargs.update({
    'run_povray': False, #True,  # Run povray or just write .pov + .ini files
    'display': False,  # Display while rendering
    'pause': True,  # Pause when done rendering (only if display)
    'transparent': False,  # Transparent background
    'canvas_width': 600,  # Width of canvas in pixels
   # 'canvas_height': 900,  # Height of canvas in pixels
   'camera_dist': 2000,  # Distance from camera to front atom
    'image_plane': None,  # Distance from front atom to image plane
  #  'camera_type': 'perspective',  # perspective, ultra_wide_angle
    'point_lights': [],             # [[loc1, color1], [loc2, color2],...]
 'area_light': [(6., 6., 100),  # location
                   'White',       # color
                   6,6, 3, 3],  # width, height, Nlamps_x, Nlamps_y
    'background': 'White',        # color
    'textures': text,  # Length of atoms list of texture names
    'celllinewidth': 0.03,  # Radius of the cylinders representing the cell
    })


#tj = sys.argv[1]   # traj file
#fz=read('POSCAR')
bondatoms=attachbonds(fz)
cell = fz.get_cell()
#ads = 'test.pov'
kwargs.update(
    {
       'bondatoms': bondatoms,
        #'bondlinewidth': 0.1,
    })
rot=[('0x,0y,0z'),('-90x,-90y,-0z'),('-90x,0y,0z'),('-78.75x,-0.148y,0z')]
#rot=[('-80.82x,29.738y,4.1406z')]
#rot=[('-78.75x,-0.148y,2.2539z')]
#rot=[('0x,0y,0z')]
for i in range(len(rot)):
    pn='%d.pov' %i
# pn= + str(pn1)
    #pn=arg+pn1
    print (pn)
    write(pn,fz, **kwargs,rotation=rot[i])
#dstDir1=arg+'_a.png'
#dstDir2=arg+'_b.png'
#os.rename('0.png',dstDir1)
#os.rename('1.png',dstDir2)

