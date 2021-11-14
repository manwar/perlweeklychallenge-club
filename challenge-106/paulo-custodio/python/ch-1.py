#!/usr/bin/env python3

# Challenge 106
#
# TASK #1 > Maximum Gap
# Submitted by: Mohammad S Anwar
# You are given an array of integers @N.
#
# Write a script to display the maximum difference between two successive
# elements once the array is sorted.
#
# If the array contains only 1 element then display 0.
#
# Example
# Input: @N = (2, 9, 3, 5)
# Output: 4
#
# Input: @N = (1, 3, 8, 2, 0)
# Output: 5
#
# Input: @N = (5)
# Output: 0

import sys

def max_gap(n):
    if len(n)<2:
        return 0
    n.sort()

    max_gap = 0
    for i in range(0, len(n)-1):
        gap = n[i+1]-n[i]
        max_gap = max(max_gap, gap)

    return max_gap

print(max_gap([int(x) for x in sys.argv[1:]]))
