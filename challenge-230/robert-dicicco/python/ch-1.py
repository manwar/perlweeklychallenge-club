#!/usr/bin/env python
'''
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Separate Digits  Task 1 ( Python )
-----------------------------------
'''

myints = [[1, 34, 5, 6], [1, 24, 51, 60]]

for ints in myints:
    print(f"Input: @ints = {ints}")
    st = ""
    for digit in ints:
        st += str(digit)
    arr = list(st)
    print("Output: [",end="")
    for ch in arr:
        print(f"{ch} ",end="")
    print("]\n")

'''
-----------------------------------
SAMPLE OUTPUT
python .\SeperateDigits.py

Input: @ints = [1, 34, 5, 6]
Output: [1 3 4 5 6 ]

Input: @ints = [1, 24, 51, 60]
Output: [1 2 4 5 1 6 0 ]
-----------------------------------
'''


