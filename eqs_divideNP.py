'''
    File:   eqs_divideNP.py
    Date:   1/3/2021
    Desc:   Generate all possible equations given a N*N two-dimensional circuit grid, based on Kirchhoff Circuit Law
    Approach: Using the Python multiprocessing module to acheive parallelism
'''

import sys
import datetime
import time 
import multiprocessing as mp
import csv

# Global variables
eqs = []
res2= []

# Convert a general equation into ij-valued:
def fill_index(i, j, k, m, n, eq):
    res = eq

    # figure out how to map k (m) into [1..n-1] for Ua's and Ub's
    if k != 0:
        k_map_val = k
        if k > j:
            k_map_val = k - 1
        res = res.replace('Ua_ijk', 'Ua['+str(i)+']['+str(j)+']['+str(k_map_val)+']')
    if m != 0:
        m_map_val = m
        if m > i:
            m_map_val = m - 1
        res = res.replace('Ub_ijm', 'Ub['+str(i)+']['+str(j)+']['+str(m_map_val)+']')

    #for U's and R's
    res = res.replace('_i', '['+str(i)+']')
    res = res.replace('j', '['+str(j)+']')
    res = res.replace('k', '['+str(k)+']')
    res = res.replace('_m', '['+str(m)+']')
    
    return res 

# Generate the equations between the i-th row and the j-th column
# Each i-j combination yields 2N equations.
def eqs_gen_ij(n):
    # Generate the equations for the entire grid
    # There are n^2 groups of equations
    global eqs
    for i in range(1, n+1):
        for j in range (1, n+1): 

            # Enforce I = Sigma(i) at the starting point
            eq_1 = 'U_ij / Z_ij - U_ij / R_ij'
            for k in range(1, n+1):
                if k != j:
                    eq_1 += ' - (U_ij - Ua_ijk) / R_ik' 
                    eq_1 = fill_index(i, j, k, 0, n, eq_1)

            # Enforce I = Sigma(i) at the end point
            eq_2 = 'U_ij / Z_ij - U_ij / R_ij'
            for m in range(1, n+1):
                if m != i:
                    eq_2 += ' - Ub_ijm / R_mj' 
                    eq_2 = fill_index(i, j, 0, m, n, eq_2)

            res = [eq_1, eq_2]
            eqs += res
    print ("Total equations (function 1): ", len(eqs))

def eqs_gen_ij2(n):
    # Generate the equations for the entire grid
    # There are n^2 groups of equations
    global res2
    for i in range(1, n+1):
        for j in range (1, n+1): 
    
            # List all the other 2(n-2) equations for intermediate joints 
            # Left (n-1) eqs:
            for k in range(1, n+1):
                if k != j: 
                    eq = '(U_ij - Ua_ijk) / R_ik'        
                    for m in range(1, n+1):
                        if m != i:
                            eq += ' - (Ua_ijk - Ub_ijm) / R_mk'
                            eq = fill_index(i, j, k, m, n, eq)
                    res2 += [eq]
            # Right (n-1) eqs:
            for m in range(1, n+1):
                if m != i: 
                    eq = 'Ub_ijm / R_mj'        
                    for k in range(1, n+1):
                        if k != j:
                            eq += ' - (Ua_ijk - Ub_ijm) / R_mk'
                            eq = fill_index(i, j, k, m, n, eq)
                    res2 += [eq]
    print ("Total equations (function 2): ", len(res2))
    
# For test only
if __name__ == '__main__':
        
    n = int(sys.argv[1])   # python eqs_gen.py 3, where 3 is the rank of the array

    start = time.time()
    # creating new process 
    p1 = mp.Process(target=eqs_gen_ij, args=(n,)) 
    p2 = mp.Process(target=eqs_gen_ij2, args=(n,))
    # starting process 
    p1.start() 
    p2.start ()
    # wait until process is finished 
    p1.join() 
    p2.join ()

    finish = time.time()
    tdelta = finish - start
    print
    print ("")
    print("Start time: %s" % start)
    print("Finish time: %s" % finish)
    print("Total Time taken to generate equations: %s" % tdelta)
    print ("")

    with open('PresultNP.csv', 'a') as newFile:
        newFileWriter = csv.writer(newFile)
        newFileWriter.writerow([n, tdelta])
