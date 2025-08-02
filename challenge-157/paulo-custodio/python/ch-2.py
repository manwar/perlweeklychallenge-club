#!/usr/bin/env python3

# Challenge 157
#
# TASK #2 > Brazilian Number
# Submitted by: Mohammad S Anwar
# You are given a number $n > 3.
#
# Write a script to find out if the given number is a Brazilian Number.
#
# A positive integer number N has at least one natural number B where
# 1 < B < N-1 where the representation of N in base B has same digits.
#
#
# Example 1:
# Input: $n = 7
# Output: 1
#
# Since 7 in base 2 is 111.
# Example 2:
# Input: $n = 6
# Output: 0
#
# Since 6 in base 2 is 110,
#       6 in base 3 is 20 and
#       6 in base 4 is 12.
# Example 3:
# Input: $n = 8
# Output: 1
#
# Since 8 in base 3 is 22.

import sys
from math import log

def cnv(n, base):
    if n == 0:
        return '0'
    digits = []
    while n:
        digits.append(int(n % base))
        n //= base
    return ''.join(str(x) for x in digits[::-1])

def is_brazilian(n):
    for b in range(2, n - 1):
        cnv_value = cnv(n, b)
        if all(c == cnv_value[0] for c in cnv_value):
            return True
    return False

n = int(sys.argv[1])
print(1 if is_brazilian(n) else 0)
