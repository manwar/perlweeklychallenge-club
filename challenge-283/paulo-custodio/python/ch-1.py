#!/usr/bin/env python3

# Challenge 283
#
# Task 1: Unique Number
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints, where every elements appears more
# than once except one element.
#
# Write a script to find the one element that appears exactly one time.
# Example 1
#
# Input: @ints = (3, 3, 1)
# Output: 1
#
# Example 2
#
# Input: @ints = (3, 2, 4, 2, 4)
# Output: 3
#
# Example 3
#
# Input: @ints = (1)
# Output: 1
#
# Example 4
#
# Input: @ints = (4, 3, 1, 1, 1, 4)
# Output: 3

import sys

ints = [int(x) for x in sys.argv[1:]]
count = {}
for x in ints:
    if x in count:
        count[x] += 1
    else:
        count[x] = 1
unique = list(filter(lambda x:count[x]==1, ints))
if len(unique) == 0:
    print(-1)
else:
    print(unique[0])
