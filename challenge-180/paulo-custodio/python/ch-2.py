#!/usr/bin/env python3

# Challenge 180
#
# Task 2: Trim List
# Submitted by: Mohammad S Anwar
#
# You are given list of numbers, @n and an integer $i.
#
# Write a script to trim the given list where element is less than or equal to
# the given integer.
# Example 1
#
# Input: @n = (1,4,2,3,5) and $i = 3
# Output: (4,5)
#
# Example 2
#
# Input: @n = (9,0,6,2,3,8,5) and $i = 4
# Output: (9,6,8,5)

import sys

if len(sys.argv) <= 2:
    raise ValueError("usage: ch-2.py list... i")

list_values = list(map(int, sys.argv[1:-1]))
i = int(sys.argv[-1])
print(", ".join(str(x) for x in list_values if x > i))
