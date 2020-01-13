#! /bin/bash

qstat -u lineng -a
echo -e "----------------------------------------\n"
echo -en "\033[31m### Please input job ID:\033[0m"
read jobId

#pwd_work=$(qstat -f $jobId |grep "WORKDIR"|awk -F "," '{print $1}'|sed "s/PBS_O_WORKDIR=//" | sed "s/[[:space:]]//g" )
#echo "Entering " ${pwd_work}
#echo -e "----------------------------------------\n"
path=`getJobPath.py $jobId`
echo "Entering" $path

cd $path


