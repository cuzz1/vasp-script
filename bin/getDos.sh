#!/bin/bash

project_path=$(pwd)
project_name="${project_path##*/}"
#echo $project_path
#echo $project_name

pydos --nofill -x -6 4 -y 0 3 -o $project_name
