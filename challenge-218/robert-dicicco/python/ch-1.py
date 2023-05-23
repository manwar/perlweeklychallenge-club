#!/usr/bin/env python

# -----------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-22
# Challenge 218 Maximum Product ( Python )
# -----------------------------------------

from itertools import combinations


lists = [[3, 1, 2],[4, 1, 3, 2],[-1, 0, 1, 3, 1],[-8, 2, -9, 0, -4, 3]]

maxthree = []

for lst in lists:
    print("Input: @list = ",lst)
    maxval = 0
    maxthree = []
    for combo in list(combinations(lst,3)):
        prod = combo[0] * combo[1] * combo[2]
        if prod > maxval:
            maxval = prod
            maxthree = combo
    print("Output: ",maxval)
    maxthree = sorted(maxthree)
    print(maxthree[0]," x ", maxthree[1], " x ", maxthree[2], " = ",maxval,"\n")
    maxval = 0

# -----------------------------------------
# SAMPLE OUTPUT
# python .\MaxProduct.py

# Input: @list =  [3, 1, 2]
# Output:  6
# 1  x  2  x  3  =  6

# Input: @list =  [4, 1, 3, 2]
# Output:  24
# 2  x  3  x  4  =  24

# Input: @list =  [-1, 0, 1, 3, 1]
# Output:  3
# 1  x  1  x  3  =  3

# Input: @list =  [-8, 2, -9, 0, -4, 3]
# Output:  216
# -9  x  -8  x  3  =  216
# -----------------------------------------


