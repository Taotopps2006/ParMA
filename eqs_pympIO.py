'''
    File:   eqs_pympIO.py
        Date:   1/3/2021
    Desc:   Generate all possible equations given a N*N two-dimensional circuit grid, based on Kirchhoff Circuit Law
            This also records the total time taken to generate the equations and write them to a file in disk
    Approach: Using the pymp package (the openMP-like functionality for python) in order to achieve automatic parallelism for the nested loop           
'''

import sys
import datetime
import time 
from joblib import Parallel, delayed
import pymp
import csv
from memory_profiler import profile
pymp.config.nested = True

# Global variables

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
# Each i-j combination yields 2N equations
def eqs_gen_ij(i, j, n):

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

    # List all the other 2(n-2) equations for intermediate joints 
    # Left (n-1) eqs:
    for k in range(1, n+1):
        if k != j: 
            eq = '(U_ij - Ua_ijk) / R_ik'        
            for m in range(1, n+1):
                if m != i:
                    eq += ' - (Ua_ijk - Ub_ijm) / R_mk'
                    eq = fill_index(i, j, k, m, n, eq)
            res += [eq]
    # Right (n-1) eqs:
    for m in range(1, n+1):
        if m != i: 
            eq = 'Ub_ijm / R_mj'        
            for k in range(1, n+1):
                if k != j:
                    eq += ' - (Ua_ijk - Ub_ijm) / R_mk'
                    eq = fill_index(i, j, k, m, n, eq)
            res += [eq]

    return res

# Generate the equations for the entire grid
# There are n^2 groups of equations
#@profile
def eqs_gen(n, thread):
    eqs = pymp.shared.list() 
    with pymp.Parallel(thread) as p1:      
        with pymp.Parallel(thread) as p2:
            for i in p1.range(1, n+1):
                for j in p2.range (1, n+1):  
                    eqs += eqs_gen_ij(i, j, n)
    
            return eqs
    
# For test only
if __name__ == '__main__':
    start = datetime.datetime.now()
    n = int(sys.argv[1])   
    thread = int(sys.argv[2])  
    eqs = eqs_gen(n, thread)    

    with open("Eqs.txt", "w")  as f:   
        f.write('\n'.join(eqs))  # or using print('\n'.join(eqs), file=f)

    finish = datetime.datetime.now()
    tdelta = finish - start

    sec = tdelta.total_seconds() # tdelta.total_seconds() is used for all the time duration, converted to seconds.  whereaas tdelta.seconds extracts the seconds field only and ignores the microseconds

    with open('PresultPymem.csv', 'a') as newFile:
        newFileWriter = csv.writer(newFile)
        newFileWriter.writerow([n, thread*2, sec])
