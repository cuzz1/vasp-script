#!/bin/bash

grep E-fermi OUTCAR | tail -1 | awk '{print $3}'
