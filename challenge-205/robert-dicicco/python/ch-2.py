#!/usr/bin/env python
'''
------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-02-20
Challenge 205 Maximum XOR ( Python )
------------------------------------
'''
from itertools import combinations

maxv = 0

arr = [[1,2,3,4,5,6,7], [2,4,1,3], [10,5,7,12,8]]

for a in arr:
    print("Input: @array = ",a)
    for a in list(combinations(a, 2)):
        x = a[0] ^ a[1]
        if x > maxv:
            maxv = x
    print("Output: ",maxv)
    print("\n")
    maxv = 0

'''
------------------------------------
SAMPLE OUTPUT
python .\MaximumXOR.py
Input: @array =  [1, 2, 3, 4, 5, 6, 7]
Output:  7


Input: @array =  [2, 4, 1, 3]
Output:  7


Input: @array =  [10, 5, 7, 12, 8]
Output:  15
------------------------------------
'''


