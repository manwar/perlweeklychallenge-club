#!/usr/bin/env python3

# Challenge 085
#
# TASK #1 > Triplet Sum
# Submitted by: Mohammad S Anwar
# You are given an array of real numbers greater than zero.
#
# Write a script to find if there exists a triplet (a,b,c) such that
# 1 < a+b+c < 2. Print 1 if you succeed otherwise 0.
#
# Example 1:
# Input: @R = (1.2, 0.4, 0.1, 2.5)
# Output: 1 as 1 < 1.2 + 0.4 + 0.1 < 2
# Example 2:
# Input: @R = (0.2, 1.5, 0.9, 1.1)
# Output: 0
# Example 3:
# Input: @R = (0.5, 1.1, 0.3, 0.7)
# Output: 1 as 1 < 0.5 + 1.1 + 0.3 < 2

import sys
from itertools import combinations

def check(nums):
    for combin in combinations(nums, 3):
        if 1.0 < sum(combin) < 2.0:
            return True
    return False

print(1 if check([float(x) for x in sys.argv[1:]]) else 0)
