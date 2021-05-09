#!/usr/bin/env python3
#
#
#       are-we-in.py
#
#       Search Matrix
#         Submitted by: Mohammad S Anwar
#         You are given 5x5 matrix filled with integers such that each row is
#         sorted from left to right and the first integer of each row is greater
#         than the last integer of the previous row.
# 
#         Write a script to find a given integer in the matrix using an
#         efficient search algorithm.
# 
#         Example
# 
#             Matrix: [  1,  2,  3,  5,  7 ]
#                     [  9, 11, 15, 19, 20 ]
#                     [ 23, 24, 25, 29, 31 ]
#                     [ 32, 33, 39, 40, 42 ]
#                     [ 45, 47, 48, 49, 50 ]
# 
#             Input:  35
#             Output: 0     since it is missing in the matrix
# 
#             Input:  39
#             Output: 1     as it exists in the matrix
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

import sys

def inArray(mat, val):
    if (val > mat[-1][-1]) | (val < mat[0][0]):
        return False 
    row = 0
    while val > mat[row][-1]:
        row += 1  
    return val in mat[row]
   
   

mat = [[  1,  2,  3,  5,  7 ],
       [  9, 11, 15, 19, 20 ],
       [ 23, 24, 25, 29, 31 ],
       [ 32, 33, 39, 40, 42 ],
       [ 45, 47, 48, 49, 50 ]] ;

default = 22

if len(sys.argv) == 1:
    val = default
else:
    val = sys.argv[1]
    
res = inArray(mat, val)

print(res)



    
    
