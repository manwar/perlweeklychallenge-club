#!/usr/bin/env python3

# Challenge 086

# TASK #1 > Pair Difference
# Submitted by: Mohammad S Anwar
# You are given an array of integers @N and an integer $A.
#
# Write a script to find find if there exists a pair of elements in the array whose difference is $A.
#
# Print 1 if exists otherwise 0.
#
# Example 1:
# Input: @N = (10, 8, 12, 15, 5) and $A = 7
# Output: 1 as 15 - 8 = 7
# Example 2:
# Input: @N = (1, 5, 2, 9, 7) and $A = 6
# Output: 1 as 7 - 1 = 6
# Example 3:
# Input: @N = (10, 30, 20, 50, 40) and $A = 15
# Output: 0

import sys

def found(dif, nums):
    for i in range(len(nums)-1):
        for j in range(i+1, len(nums)):
            if abs(nums[i]-nums[j])==dif:
                return True
    return False

nums = [int(x) for x in sys.argv[1:]]
dif = nums.pop(-1)
if found(dif, nums):
    print(1)
else:
    print(0)
