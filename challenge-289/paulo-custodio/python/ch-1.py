#!/usr/bin/env python3

# Challenge 289
#
# Task 1: Third Maximum
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints.
#
# Write a script to find the third distinct maximum in the given array. If
# third maximum doesn't exist then return the maximum number.
# Example 1
#
# Input: @ints = (5, 6, 4, 1)
# Output: 4
#
# The first distinct maximum is 6.
# The second distinct maximum is 5.
# The third distinct maximum is 4.
#
# Example 2
#
# Input: @ints = (4, 5)
# Output: 5
#
# In the given array, the third maximum doesn't exist therefore returns the
# maximum.
#
# Example 3
#
# Input: @ints =  (1, 2, 2, 3)
# Output: 1
#
# The first distinct maximum is 3.
# The second distinct maximum is 2.
# The third distinct maximum is 1.

import sys

nums = sorted(set(map(int, sys.argv[1:])), reverse=True)
print(nums[2] if len(nums) > 2 else nums[0])
