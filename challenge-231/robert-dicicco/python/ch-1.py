#!/usr/bin/env python
'''
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Min Max Task 1 ( Python )
----------------------------------------
'''

myints = [[3, 2, 1, 4],[3, 1],[2, 1, 3]]

for mints in myints:
    arr = []
    print("Input: @ints = ",mints)
    print("Output: ",end="")
    if len(mints) <= 2:
        print("-1\n")
        continue
    minm = min(mints)
    maxm = max(mints)
    for i in mints:
        if i > minm and i < maxm:
            arr.append(i)
    print(f"{arr}\n")

'''
SAMPLE OUTPUT
python .\MinMax.py

Input: @ints =  [3, 2, 1, 4]
Output: [3, 2]

Input: @ints =  [3, 1]
Output: -1

Input: @ints =  [2, 1, 3]
Output: [2]
'''


