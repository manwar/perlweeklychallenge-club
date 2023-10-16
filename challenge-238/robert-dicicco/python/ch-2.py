#!/usr/bin/env python
'''
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-12
Challenge 238 Task 02 Persistence Sort ( Python )
----------------------------------------
'''
import math
from operator import itemgetter

myints = [[15, 99, 1, 34],[50, 25, 33, 22]]

def Reduce ( num ):
    if num < 0 or num > 99:
        return 0
    steps = 0;
    while num > 9:
        num = math.floor(num/10) * (num % 10)
        steps += 1
    return steps

for mints in myints:
    print("Input: @int = ",mints)
    cnt = 0
    h = {}
    while cnt < len(mints):
        retval = Reduce(mints[cnt])
        h[mints[cnt]] = retval
        cnt += 1
    res = dict(sorted(h.items(), key=itemgetter(1, 0)))
    print("Output: [ ", end="")
    for key in res.keys():
        print(f"{key} ",end="")
    print("]\n")

'''
----------------------------------------
SAMPLE OUTPUT
python .\Persistence.py

Input: @int =  [15, 99, 1, 34]
Output: [ 1 15 34 99 ]

Input: @int =  [50, 25, 33, 22]
Output: [ 22 33 50 25 ]
----------------------------------------
'''


