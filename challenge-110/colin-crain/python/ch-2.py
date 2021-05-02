#!/usr/bin/env python3
#
#       reflect.py
#
#       Transpose File
#         Submitted by: Mohammad S Anwar
#         You are given a text file.
# 
#         Write a script to transpose the contents of the given file.
# 
#         Input File
#             name,age,sex
#             Mohammad,45,m
#             Joe,20,m
#             Julie,35,f
#             Cristina,10,f
# 
#         Output:
#             name,Mohammad,Joe,Julie,Cristina
#             age,45,20,35,10
#             sex,m,m,f,f
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


import re

mat   = []
trans = []
cols  = 0

f = open("transpose-data.txt", "r")
for line in f:
    row = re.split(",", line.rstrip())
    mat.append(row)
    cols = max(cols, len(row))
f.close
    

trans = [[mat[j][i] for j in range(len(mat))] for i in range(len(mat[0]))]

for i in mat:
    print( *i )

print()

for i in trans:
    print( *i )

