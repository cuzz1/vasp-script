#! /bin/env

import matplotlib.pyplot as plt
import numpy as np

# x, y = np.loadtxt("energy.txt", delimiter=" ", unpack = True)

x_list = []
y_list = []

with open("energy.txt") as f:
    lines = f.readlines();
    for line in lines:
        print line
        a, b = line.split()
        x_list.append(a)
        y_list.append(float(b))
print x_list
print y_list

plt.title('Figure', fontsize=30)
plt.xlabel('Group number', fontsize=28)
plt.ylabel('Energy (eV)', fontsize=28)

#for a, b in zip(x_list, y_list):  
   # plt.text(a, b, (a,round(b, 2)),ha='center', va='bottom', fontsize=10) 

#my_x_ticks = np.arange(-0.95, 1.10, 0.01)
#my_y_ticks = np.arange(-140, -130, 2)

#plt.xticks(my_x_ticks)
#plt.yticks(my_y_ticks)

plt.plot(x_list, y_list, marker="o",linewidth=5)

#plt.bar(range(len(x_list)), y_list, color="rgb", tick_label=x_list)
plt.show()
