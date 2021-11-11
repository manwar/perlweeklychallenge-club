#!/usr/bin/env python3

# Challenge 084
#
# TASK #1 > Reverse Integer
# Submitted by: Mohammad S Anwar
# You are given an integer $N.
#
# Write a script to reverse the given integer and print the result. Print 0 if
# the result doesn't fit in 32-bit signed integer.
#
# The number 2,147,483,647 is the maximum positive value for a 32-bit signed binary
# integer in computing.
#
# Example 1:
# Input: 1234
# Output: 4321
# Example 2:
# Input: -1234
# Output: -4321
# Example 3:
# Input: 1231230512
# Output: 0

import sys

def reverse_int(n):
    if n < -0x80000000 or n > 0x7fffffff:
        return 0
    rev = 0
    if n < 0:
        sign = -1
        n = -n
    else:
        sign = 1
    while n > 0:
        rev = 10 * rev + n%10
        n //= 10
    rev *= sign
    return rev

print(reverse_int(int(sys.argv[1])))
