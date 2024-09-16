#!/usr/bin/env python3

# Challenge 051
#
# TASK #1
# 3 Sum
# Given an array @Lof integers. Write a script to find all unique triplets such
# that a + b + c is same as the given target T. Also make sure a <= b <= c.
#
# Here is wiki page for more information.
#
# Example:
#
# @L = (-25, -10, -7, -3, 2, 4, 8, 10);
#
# One such triplet for target 0 i.e. -10 + 2 + 8 = 0.

import sys

TARGET = 0

def _3sum(nums):
    for i in range(len(nums)-2):
        outi = "+"+str(nums[i]) if nums[i] >= 0 else str(nums[i])
        for j in range(i+1, len(nums)-1):
            outj = "+"+str(nums[j]) if nums[j] >= 0 else str(nums[j])
            for k in range(j+1, len(nums)):
                outk = "+"+str(nums[k]) if nums[k] >= 0 else str(nums[k])
                if sum([nums[i], nums[j], nums[k]]) == TARGET:
                    return outi+outj+outk+"="+str(TARGET)
    return ""

print(_3sum([int(x) for x in sys.argv[1:]]))
