#!/usr/bin/env python3

# Challenge 072
#
# TASK #1 > Trailing Zeroes
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N (<= 10).
#
# Write a script to print number of trailing zeroes in $N!.
#
# Example 1
# Input: $N = 10
# Output: 2 as $N! = 3628800 has 2 trailing zeroes
#
# Example 2
# Input: $N = 7
# Output: 1 as $N! = 5040 has 1 trailing zero
#
# Example 3
# Input: $N = 4
# Output: 0 as $N! = 24 has 0 trailing zero

import re
import sys

def fact(n):
    if n < 2:
        return 1
    else:
        return n*fact(n-1)

def trailing_zeros(n):
    s = str(n)
    if m := re.search(r'0+$', s):
        return len(m.group(0))
    else:
        return 0

N = int(sys.argv[1])
print(trailing_zeros(fact(N)))
