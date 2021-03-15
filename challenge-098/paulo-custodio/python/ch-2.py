#!/usr/bin/env python

# Challenge 098
#
# TASK #2 > Search Insert Position
# Submitted by: Mohammad S Anwar
# You are given a sorted array of distinct integers @N and a target $N.
#
# Write a script to return the index of the given target if found
# otherwise place the target in the sorted array and return the index.
#
# Example 1:
# Input: @N = (1, 2, 3, 4) and $N = 3
# Output: 2 since the target 3 is in the array at the index 2.
# Example 2:
# Input: @N = (1, 3, 5, 7) and $N = 6
# Output: 3 since the target 6 is missing and should be placed at
# the index 3.
# Example 3:
# Input: @N = (12, 14, 16, 18) and $N = 10
# Output: 0 since the target 10 is missing and should be placed at
# the index 0.
# Example 4:
# Input: @N = (11, 13, 15, 17) and $N = 19
# Output: 4 since the target 19 is missing and should be placed at
# the index 4.

import sys

# use bisect method to search for position
def search_insert(nums, n):
    if len(nums) == 0:          # input empty
        nums.append(n)
        return 0
    elif n < nums[0]:           # before first
        nums.insert(0, n)
        return 0
    elif n > nums[-1]:          # after last
        nums.append(n)
        return len(nums)-1
    else:                       # bisect
        b = 0
        t = len(nums)
        m = int((t+b)/2)
        while b+1 < t:
            if n == nums[m]:
                return m
            elif n < nums[m]:
                t = m
            else:
                b = m
            m = int((t+b)/2)
        # not found, insert at m+1
        nums.insert(m+1, n)
        return m+1

# main
nums = []
n = int(sys.argv[1])
for i in range(2, len(sys.argv)):
    nums.append(int(sys.argv[i]))
p = search_insert(nums, n)
print(p)
print("(" + (", ".join([str(x) for x in nums])) + ")")
