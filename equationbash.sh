#! /bin/bash

# File: equationbash.sh
#  Date:   1/3/2021
# Desc: bash script to run PyMP Implementation on the Z820 server .
#                      How to run scipt
# chmod +x equationbash.sh
# ./equationbash.sh 

for ((i=1;i<=16;i*=2))   ### outer loop for threads up to 32 threads ###
do
	for ((j=10;j<=100;j+=10))   ### outer loop for array rank up to 100 ###
	do
		python eqs_pymp.py $j $i    ### change to python eqs_pympIO.py $j $i  in order to run Pymp implementation with I/O script
	done
done
