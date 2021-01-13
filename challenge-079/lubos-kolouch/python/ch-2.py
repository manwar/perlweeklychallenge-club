#!/bin/env python
"""
===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py
#
#  DESCRIPTION: Perl Weekly Challenge Task 2
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-079/
#               Trapper Rain Water
#
#       AUTHOR: Lubos Kolouch
#==============================================================================
"""

def trapWater(arr):

    n = len(arr)
    left = [0]*n
    right = [0]*n

    water = 0

    left[0] = arr[0]
    for i in range(1, len(arr)):
        left[i] = max(left[i-1], arr[i])

    right[n-1] = arr[n-1]
    for i in range(n-2, -1, -1):
        right[i] = max(right[i + 1], arr[i])

    for i in range(0, n):
        water += min(left[i], right[i]) - arr[i]

    return water

assert trapWater([2, 1, 4, 1, 2, 5]) == 6
assert trapWater([3, 1, 3, 1, 1, 5]) == 6

