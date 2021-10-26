#!/usr/bin/env python3

# TASK #1 > Integer Square Root
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to calculate the integer square root of the given number.
#
# Please avoid using built-in function. Find out more about it here.
#
# Examples
# Input: $N = 10
# Output: 3
#
# Input: $N = 27
# Output: 5
#
# Input: $N = 85
# Output: 9
#
# Input: $N = 101
# Output: 10

# solution: https://en.wikipedia.org/wiki/Integer_square_root

import sys

def isqrt(n):
    x0 = n >> 1         # initial estimate
    if x0 == 0:
        return n

    # loop
    x1 = int(x0 + n/x0) >> 1
    while x1 < x0:
        x0 = x1;
        x1 = int(x0 + n/x0) >> 1

    return x0

n = int(sys.argv[1])
print(isqrt(n))
