#!/usr/bin/env python3

# TASK #1 > Middle 3-digits
# Submitted by: Mohammad S Anwar
# You are given an integer.
# 
# Write a script find out the middle 3-digits of the given integer, if possible otherwise throw sensible error.
# 
# Example 1
# Input: $n = 1234567
# Output: 345
# Example 2
# Input: $n = -123
# Output: 123
# Example 3
# Input: $n = 1
# Output: too short
# Example 4
# Input: $n = 10
# Output: even number of digits

import sys

def mid3digits(n):
    l = len(str(n))
    if l%2==0:
        return "even number of digits"
    elif l<3:
        return "too short"
    else:
        s = int((l-3)/2)
        return str(n)[s:s+3];

n = abs(int(str(sys.argv[1])))
print(mid3digits(n))
