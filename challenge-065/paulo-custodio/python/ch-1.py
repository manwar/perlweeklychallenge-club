#!/usr/bin/env python3

# Challenge 065
#
# TASK #1 > Digits Sum
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# You are given two positive numbers $N and $S.
#
# Write a script to list all positive numbers having exactly $N digits where sum
# of all digits equals to $S.
#
# Example
# Input:
#     $N = 2
#     $S = 4
#
# Output:
#     13, 22, 31, 40

import sys
from itertools import product

def digits_sum(N, S):
    out = []
    for n in range(10**(N-1), 10**N):
        if sum(int(d) for d in str(n)) == S:
            out.append(n)
    return out

N, S = map(int, sys.argv[1:])
out = digits_sum(N, S)
print(", ".join(map(str, out)))
