#!/home/lineng/software/python36/bin/python3.6

import sys
import subprocess

job_id = sys.argv[1]
            


cmd = "qstat -f " + job_id
(status, output) = subprocess.getstatusoutput(cmd)
if status == 0:
    list = output.split("\n")
    # print(list)
    #for i in range(len(list)):
    #    print(str(i) + "  " + list[i])
    #    print("\n")
    path = ""
    for i in range(len(list)):
        if list[i].find("Error_Path") != -1:
            path = list[i] + list[i+1]
            break

    #if list[15].find("exec_host") != -1:
    #    # 13 14 
    #    path = list[13] + list[14]
    #
    #else:
    #    # 13
    #    path = list[13]

    path = "".join(path.split()).replace("Error_Path=mu01:","")
    endIndex = path.index("/$PBS_JOBID.e")
    path = path[0:endIndex]
    print(path)


else:
    print(output)
                        
            
        
           
	

			




