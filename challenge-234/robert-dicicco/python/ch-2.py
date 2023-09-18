#!/usr/bin/env python
'''
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-14
Challenge 234 Task 2 Unequal Triplets ( Python )
-----------------------------------
'''

from itertools import combinations

myints = [[4, 4, 2, 4, 3],[1, 1, 1, 1, 1],[4, 7, 1, 10, 7, 4, 1, 1]]

for mints in myints:
    cnt = 0
    print(f"Inputs: @ints = {mints}")
    for res in (list(combinations(mints, 3))):
        if ((res[0] != res[1]) and (res[1] != res[2]) and (res[0] != res[2])):
            cnt += 1
    print(f"Output: {cnt}\n")

# -----------------------------------
# SAMPLE OUTPUT
# python .\UnequalTriplets.py

# Inputs: @ints = [4, 4, 2, 4, 3]
# Output: 3

# Inputs: @ints = [1, 1, 1, 1, 1]
# Output: 0

# Inputs: @ints = [4, 7, 1, 10, 7, 4, 1, 1]
# Output: 28
# ----------------------------------

