#!/usr/bin/env python
# --------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-15
# Challenge 217 Sorted Matrix ( Python )
# --------------------------------------

matrix = [[3,1,2],[5,2,4],[0,1,3]],  [[2,1], [4,5]], [[1,0,3],[0,0,0],[ 1,2,1]]

for mat in matrix:
    out = []
    print("Input: @matrix = ",mat)
    for arr in mat:
        for num in arr:
            out.append(num)
    out.sort()
    print("out = ",out[2])
    print(" ")


# -------------------------------------
# SAMPLE OUTPUT
# python .\SortedMatrix.py
# Input: @matrix =  [[3, 1, 2], [5, 2, 4], [0, 1, 3]]
# out =  1

# Input: @matrix =  [[2, 1], [4, 5]]
# out =  4

# Input: @matrix =  [[1, 0, 3], [0, 0, 0], [1, 2, 1]]
# out =  0
# -------------------------------------


