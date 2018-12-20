import numpy as np
import matplotlib as mpl
mpl.rcParams['font.size'] = 12.
#mpl.rc('font',family='Times New Roman')
from matplotlib import pyplot as plt
import matplotlib.ticker as ticker

lwd=0.2
op=0.8
fig= plt.figure(figsize=(3.0,5))
data=np.loadtxt("EBS.dat")
#kpath=np.loadtxt("KPATH.dat")
kpt=data[:,0]                   # kpath 
eng=data[:,1]                   # energy level
wgt=data[:,2]*20                # weight, 20 is enlargement factor
ax = fig.add_subplot(111)
ax.scatter(kpt,eng,wgt,edgecolor = 'blue',alpha=op)
plt.axhline(y=0, xmin=kpt.min(), xmax=kpt.max(), linewidth=0.6, color = 'k')
plt.axvline(x=0.68, ymin=eng.min(), ymax=eng.max(), linewidth=0.6, color = 'k')
ax.yaxis.set_minor_locator(ticker.MultipleLocator(0.40))
ax.set_ylim(-4,4)
plt.yticks(np.arange(-6, 4.1, 2))
plt.xlim(kpt.min(), kpt.max())
xticks=[0, 0.68, kpt.max()]
xlabels=['M', 'K', r'$\Gamma$']
ax.set_xticks(xticks)
ax.set_xticklabels(xlabels)
plt.savefig('ebs.pdf',dpi=100)
