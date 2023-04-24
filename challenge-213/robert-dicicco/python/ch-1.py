#!/usr/bin/env python
'''
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-17
Challenge 213 Fun Sort ( Python )
-----------------------------------
'''
import numpy as np

mylists = [[1,2,3,4,5,6],[1,2],[1]]

for arr in mylists:
    print("Input: @list = ",arr)
    evens = np.array([num for num in arr if num % 2 == 0])
    odds  = np.array([num for num in arr if num % 2 == 1])
    if (evens.size and odds.size):
        combo = np.concatenate((evens,odds))
        print(combo)
    else:
        print(evens) if evens.size else print(odds)
'''
-----------------------------------
SAMPLE OUTPUT
 python .\FunSort.py
Input: @list =  [1, 2, 3, 4, 5, 6]
[2 4 6 1 3 5]
Input: @list =  [1, 2]
[2 1]
Input: @list =  [1]
[1]
-----------------------------------
'''


