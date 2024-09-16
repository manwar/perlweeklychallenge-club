#!/usr/bin/env python3

# Challenge 284
#
# Task 1: Lucky Integer
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints.
#
# Write a script to find the lucky integer if found otherwise return -1. If
# there are more than one then return the largest.
#
#     A lucky integer is an integer that has a frequency in the array equal to
#     its value.
#
# Example 1
#
# Input: @ints = (2, 2, 3, 4)
# Output: 2
#
# Example 2
#
# Input: @ints = (1, 2, 2, 3, 3, 3)
# Output: 3
#
# Example 3
#
# Input: @ints = (1, 1, 1, 3)
# Output: -1

import sys

ints = [int(x) for x in sys.argv[1:]]
count = {}
for x in ints:
    if x in count:
        count[x] += 1
    else:
        count[x] = 1
lucky = sorted(list(filter(lambda x:x == count[x], ints)))[::-1]
if len(lucky) > 0:
    print(lucky[0])
else:
    print(-1)
