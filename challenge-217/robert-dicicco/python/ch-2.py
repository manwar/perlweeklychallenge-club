#!/usr/bin/env python
# ---------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-16
# Challenge 217 Max Number ( Python )
# ---------------------------------------

from itertools import permutations


mylist = [[5,11,4,1,2],[31, 2, 4,10],[10,3,2],[1, 23],[1,10]];
max = 0

for lst in mylist:
    print("Input: @list = ",lst)
    perm = permutations(lst)

    for i in list(perm):
        val = ''.join(str(element) for element in i)
        val = int(val)
        if val > max:
            max = val

    print("Output: ",max,"\n")
    max = 0

# ---------------------------------------
# SAMPLE OUTPUT
# python .\MaxNumber.py
# Input: @list =  [5, 11, 4, 1, 2]
# Output:  542111

# Input: @list =  [31, 2, 4, 10]
# Output:  431210

# Input: @list =  [10, 3, 2]
# Output:  3210

# Input: @list =  [1, 23]
# Output:  231

# Input: @list =  [1, 10]
# Output:  110
# ---------------------------------------


