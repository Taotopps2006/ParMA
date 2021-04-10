#! /bin/bash

# File: memory.sh
#     Date:   1/3/2021
# Desc: bash script to observe the peak (i.e. the highest) memory usage and the time-based memory usage (at an interval of 0.1 seconds) for threads per specified rank in the various levels of parallelismin PyMP
#                      How to run scipt
# stary by installing the  python memory profiler module using "pip install memory-profiler"
# chmod +x memory.sh 
# ./memory.sh

for ((i=1;i<=16;i*=2))   ### outer loop for threads up to 32 threads ###
do
	for ((j=10;j<=100;j+=10))   ### outer loop for array rank up to 100 ###
	do
		mprof run eqs_pymp.py $j $i    ### change to "mprof run eqs_pympIO.py $j $i"  in order to run the Pymp implementation with I/O script
	done
done
