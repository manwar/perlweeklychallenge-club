#!/usr/bin/env python3

# Challenge 292
#
# Task 1: Twice Largest
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints, where the largest integer is unique.
#
# Write a script to find whether the largest element in the array is at least twice as big as every element in the given array. If it is return the index of the largest element or return -1 otherwise.
# Example 1
#
# Input: @ints = (2, 4, 1, 0)
# Output: 1
#
# The largest integer is 4.
# For every other elements in the given array is at least twice as big.
# The index value of 4 is 1.
#
# Example 2
#
# Input: @ints = (1, 2, 3, 4)
# Output: -1
#
# The largest integer is 4.
# 4 is less than twice the value of 3, so we return -1.

import sys

nums = sorted([[i-1, int(sys.argv[i])] for i in range(1, len(sys.argv))], key=lambda x: x[1], reverse=True)
if len(nums) >= 2 and nums[0][1] >= 2 * nums[1][1]:
    print(nums[0][0])
else:
    print(-1)
