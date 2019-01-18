#!/bin/bash

echo "remove WAECAR ACCAAR* CHG*"
du -sh *
# Do you want to run?
echo -e -n "\033[31m### Are you sure to execute this shell [y/n]: \033[0m"
read flag

if [ ${flag} != "y" ]; then
    exit
fi

find . -name WAVECAR  -print |xargs rm
find . -name AECCAR*  -print |xargs rm
find . -name CHG*  -print |xargs rm
