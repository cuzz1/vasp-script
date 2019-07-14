#! /bin/bash

qstat -u lineng -a
echo -n "Please input job Id: "
read jobId

pwd_work=$(qstat -f $jobId |grep "WORKDIR"|awk -F "," '{print $1}'|sed "s/PBS_O_WORKDIR=//" | sed "s/[[:space:]]//g" )
echo ${pwd_work}

cd $pwd_work


