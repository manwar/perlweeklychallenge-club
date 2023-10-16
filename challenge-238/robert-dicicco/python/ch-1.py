#!/usr/bin/env python
'''
---------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-09
Challenge 238 Task 01 Running Sum ( Python )
---------------------------------
'''

myints = [[1, 2, 3, 4, 5],[1, 1, 1, 1, 1],[0, -1, 1, 2]]

for mints in myints:
    print(f"Input: @int = {mints}")
    sum = 0
    out = []
    for i in mints:
        out.append(i + sum)
        sum += i
    print(f"Output: {out}\n")

    '''
---------------------------------
SAMPLE OUTPUT
python .\RunningSum.py

Input: @int = [1, 2, 3, 4, 5]
Output: [1, 3, 6, 10, 15]

Input: @int = [1, 1, 1, 1, 1]
Output: [1, 2, 3, 4, 5]

Input: @int = [0, -1, 1, 2]
Output: [0, -1, 0, 2]
---------------------------------
'''


