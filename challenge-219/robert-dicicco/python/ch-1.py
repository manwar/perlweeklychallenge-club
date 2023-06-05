#!/usr/bin/env python

#--------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-29
# Challenge 219 Sorted Squares Task 1 ( Python )
#--------------------------------------

mylist = [[-2, -1, 0, 3, 4],
       [5, -4, -1, 3, 6]
      ];

for lst in mylist:
    print("Input: @list = ",lst)
    print(sorted(list(map(lambda x: x * x, lst))),"\n")

#--------------------------------------
# SORTED OUTPUT
# python .\SortedSquares.py

# Input: @list =  [-2, -1, 0, 3, 4]
# [0, 1, 4, 9, 16]

# Input: @list =  [5, -4, -1, 3, 6]
# [1, 9, 16, 25, 36]

#--------------------------------------


