#!/usr/bin/python
# -*- coding:utf-8 -*-
import numpy as np
import matplotlib as mpl
mpl.use('Agg') #silent mode
mpl.rcParams['font.size'] = 16.
#mpl.rc('font',family='Times New Roman')
from matplotlib import pyplot as plt
import matplotlib.ticker as ticker


group_labels=[]
x=[]

with open("./EBS_2x2/KLABELS",'r') as reader:
    lines=reader.readlines()[1:]
for i in lines:
    s=i.encode('utf-8')#.decode('latin-1')
    if len(s.split())==2 and not s.decode('utf-8','ignore').startswith("*"):
        group_labels.append(s.decode('utf-8','ignore').split()[0])
        x.append(float(s.split()[1]))

for index in range(len(group_labels)):
	if group_labels[index]=="GAMMA":
		group_labels[index]=u"Γ"


lwd=0.1
op=0.4
fig= plt.figure(figsize=(6.0,10))
data=np.loadtxt("./EBS_2x2/EBS.dat")
kpt=data[:,0]                   # kpath 
eng=data[:,1]                   # energy level
wgt=data[:,2]*80                # weight, 50 is enlargement factor
ax = fig.add_subplot(111)
ax.yaxis.set_minor_locator(ticker.MultipleLocator(0.40))
ax.set_ylim(-12,12)
ytick=np.arange(-12, 12.1, 4)
a=int(len(ytick)/2)
plt.yticks(np.insert(ytick,a,0))
ax.set_xticks(x)
plt.yticks(fontsize=15,fontname='arial')
ax.set_xticklabels(group_labels, rotation=0,fontsize=15,fontname='arial')
#fig = plt.gcf()
#fig.set_size_inches(8,6)
#plt.show()
lwd=0.2
op=1
data=np.loadtxt("./PRIMCELL/BAND.dat")
kpt=data[:,0]                   # kpath
eng=data[:,1]                   # energy level
ax.scatter(kpt,eng,wgt,edgecolor = 'blue',alpha=op)
ax.plot(kpt,eng,color='red',lw=1.5)
ax.legend(('Band for primitive cell','EBS for 2x2 supercell'),loc='best',shadow=False,labelspacing=0.1,fontsize=15)
ax.axhline(y=0, xmin=0, xmax=1,linestyle= '-',linewidth=0.5,color='0.5')
for i in x[1:-1]:
	ax.axvline(x=i, ymin=0, ymax=1,linestyle= '-',linewidth=0.5,color='0.5')
ax.set_xlim((x[0], x[-1]))
plt.ylabel(r"E-E$_{F}$ (eV)")
plt.savefig('ebs.pdf',dpi=100)
