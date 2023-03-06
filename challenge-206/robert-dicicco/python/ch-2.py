#!/usr/bin/env python
'''
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-01
Challenge 206 Array Pairings ( Python )
----------------------------------------
'''

import array as a

arrs = [[1,2,3,4],[0,2,1,3]]
pairs = [[0,1,2,3], [0,2,1,3], [0,3,1,2]]
maxval = 0

for arr in arrs:
    print("Input: @array = ",arr)
    for pr in pairs:
        a1 = pr[0:2]
        sum1 = arr[min(a1)]
        a2 = pr[2:]
        sum2 = arr[min(a2)]
        sum = sum1 + sum2
        if sum > maxval :
            maxval = sum

    print("Output: ",maxval,"\n")
    maxval = 0

'''
----------------------------------------
SAMPLE OUTPUT
python .\ArrayPairings.py
Input: @array =  [1, 2, 3, 4]
Output:  4

Input: @array =  [0, 2, 1, 3]
Output:  2
----------------------------------------
'''


