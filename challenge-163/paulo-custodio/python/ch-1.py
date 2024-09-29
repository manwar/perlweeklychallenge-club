#!/usr/bin/env python3

# Challenge 163
#
# Task 1: Sum Bitwise Operator
# Submitted by: Mohammad S Anwar
#
# You are given list positive numbers, @n.
#
# Write script to calculate the sum of bitwise & operator for all unique pairs.
# Example 1
#
# Input: @n = (1, 2, 3)
# Output: 3
#
# Since (1 & 2) + (2 & 3) + (1 & 3) => 0 + 2 + 1 =>  3.
#
# Example 2
#
# Input: @n = (2, 3, 4)
# Output: 2
#
# Since (2 & 3) + (2 & 4) + (3 & 4) => 2 + 0 + 0 =>  2.

def sum_biwise_and(*n):
    total_sum = 0
    for i in range(len(n) - 1):
        for j in range(i + 1, len(n)):
            total_sum += n[i] & n[j]
    return total_sum

import sys
print(sum_biwise_and(*map(int, sys.argv[1:])))
