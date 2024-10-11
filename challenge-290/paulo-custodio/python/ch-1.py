#!/usr/bin/env python3

# Challenge 290
#
# Task 1: Double Exist
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of integers, @ints.
#
# Write a script to find if there exist two indices $i and $j such that:
#
# 1) $i != $j
# 2) 0 <= ($i, $j) < scalar @ints
# 3) $ints[$i] == 2 * $ints[$j]
#
# Example 1
#
# Input: @ints = (6, 2, 3, 3)
# Output: true
#
# For $i = 0, $j = 2
# $ints[$i] = 6 => 2 * 3 =>  2 * $ints[$j]
#
# Example 2
#
# Input: @ints = (3, 1, 4, 13)
# Output: false
#
# Example 3
#
# Input: @ints = (2, 1, 4, 2)
# Output: true
#
# For $i = 2, $j = 3
# $ints[$i] = 4 => 2 * 2 =>  2 * $ints[$j]

def double_exist(n):
    for i in range(len(n) - 1):
        for j in range(i + 1, len(n)):
            if n[i] == 2 * n[j] or n[j] == 2 * n[i]:
                return True
    return False

import sys
print("true" if double_exist(list(map(int, sys.argv[1:]))) else "false")
