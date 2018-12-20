#!/usr/bin/python
# -*- coding:utf-8 -*-
import numpy as np
import matplotlib as mpl
mpl.use('Agg') #silent mode
from matplotlib import pyplot as plt
import matplotlib.ticker as ticker


try:
    hsp=np.loadtxt("KLABELS", dtype=np.string_,skiprows=1,usecols = (0,1))
    df=np.loadtxt("BAND-REFORMATTED.dat",dtype=np.float64)
    group_labels = hsp[:-2,0].tolist()
    group_labels = [i.decode('utf-8','ignore') for i in group_labels]
    for index in range(len(group_labels)):
    	if group_labels[index]=="GAMMA":
    		group_labels[index]=u"Γ"

    x = [float(i) for i in hsp[:-2,1].tolist()]

except:
    print("failed to open KLABELS containing High symmetry point!")



axe = plt.subplot(111)
axe.plot(df[:,0],df[:,1:],linewidth=1.0,color='blue')
font = {'family' : 'arial',  
        'color'  : 'black',  
        'weight' : 'normal',  
        'size'   : 13,  
        }  

#axe.set_xlabel(r'$\mathbf{k}$-points',fontsize=13)
axe.set_ylabel(r'${E}$-$E_{f}$ (eV)',fontdict=font)
axe.set_xticks(x)
plt.yticks(fontsize=10,fontname='arial')
#plt.yticks(fontdict=ticksfont)
axe.set_xticklabels(group_labels, rotation=0,fontsize=10,fontname='arial')
axe.axhline(y=0, xmin=0, xmax=1,linestyle= '--',linewidth=0.5,color='0.5')
for i in x[1:-1]:
	axe.axvline(x=i, ymin=0, ymax=1,linestyle= '--',linewidth=0.5,color='0.5')
axe.set_xlim((x[0], x[-1]))
plt.ylim((-15, 10)) # set y limits manually
fig = plt.gcf()
fig.set_size_inches(8,6)
#plt.show()
plt.savefig('band.png',dpi=1000)
