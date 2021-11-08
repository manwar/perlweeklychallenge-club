#!/usr/bin/env python3

# Challenge 115
#
# TASK #2 - Largest Multiple
# Submitted by: Mohammad S Anwar
# You are given a list of positive integers (0-9), single digit.
#
# Write a script to find the largest multiple of 2 that can be formed from the
# list.
#
# Examples
# Input: @N = (1, 0, 2, 6)
# Output: 6210
#
# Input: @N = (1, 4, 2, 8)
# Output: 8412
#
# Input: @N = (4, 1, 7, 6)
# Output: 7614

import sys

def largest_mult2(nums):
    # select smallest even number for last element
    even = list(filter(lambda x: x%2 == 0, nums))
    if len(even)==0:
        return 0        # no even numbers
    even.sort()
    last = even[0]

    # sort the other elements in descending order
    nums = list(filter(lambda x: x!=last, nums))
    nums.sort()
    nums = nums[::-1]

    return int("".join([str(x) for x in [*nums, last]]))

print(largest_mult2([int(x) for x in sys.argv[1:]]))
