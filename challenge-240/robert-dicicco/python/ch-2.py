#!/usr/bin/env python

# -----------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 23-OCT-2023
# Challenge 240 Task 02 Build Array ( Python )
# -----------------------------------

myints = [[0, 2, 1, 5, 3, 4],[5, 0, 1, 2, 3, 4]]

for mints in myints:
    out = []
    print(f"Input: @ints = {mints}")
    cnt = 0
    while cnt < len(mints):
        out.append(mints[mints[cnt]])
        cnt += 1
    print(f"Output: {out}\n")

# -----------------------------------
# SAMPLE OUTPUT
# python .\BuildArray.py

# Input: @ints = [0, 2, 1, 5, 3, 4]
# Output: [0, 1, 2, 4, 5, 3]

# Input: @ints = [5, 0, 1, 2, 3, 4]
# Output: [4, 5, 0, 1, 2, 3]
# -----------------------------------



