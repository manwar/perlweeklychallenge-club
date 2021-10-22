#!/usr/bin/env python3

# TASK #1 > Odd Number
# Submitted by: Mohammad S Anwar
# You are given an array of positive integers, such that all the
# numbers appear even number of times except one number.
# 
# Write a script to find that integer.
# 
# Example 1
# Input: @N = (2, 5, 4, 4, 5, 5, 2)
# Output: 5 as it appears 3 times in the array where as all other
# numbers 2 and 4 appears exactly twice.
# Example 2
# Input: @N = (1, 2, 3, 4, 3, 2, 1, 4, 4)
# Output: 4

import sys

N = sys.argv[1:]
count = {}
for n in N:
    if n not in count:
        count[n] = 1
    else:
        count[n] += 1
for n,count in count.items():
    if count%2==1:
        print(n)
