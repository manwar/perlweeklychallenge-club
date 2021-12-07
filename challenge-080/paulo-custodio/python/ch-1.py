#!/usr/bin/python3

# Challenge 080
#
# TASK #1 > Smallest Positive Number
# Submitted by: Mohammad S Anwar
# You are given unsorted list of integers @N.
#
# Write a script to find out the smallest positive number missing.
#
# Example 1:
# Input: @N = (5, 2, -2, 0)
# Output: 1
# Example 2:
# Input: @N = (1, 8, -1)
# Output: 2
# Example 3:
# Input: @N = (2, 0, -1)
# Output: 1

import sys

def missing(nums):
    nums = sorted(filter(lambda x:x>0, nums))
    for a,b in zip(nums, range(1, len(nums)+1)):
        if a!=b:
            return b
    return len(nums)+1

print(missing([int(x) for x in sys.argv[1:]]))
