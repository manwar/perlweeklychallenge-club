#!/usr/bin/env python3

# Challenge 105
#
# TASK #1 > Nth root
# Submitted by: Mohammad S Anwar
# You are given positive numbers $N and $k.
#
# Write a script to find out the $Nth root of $k. For more information, please
# take a look at the wiki page.
#
# Example
# Input: $N = 5, $k = 248832
# Output: 12
#
# Input: $N = 5, $k = 34
# Output: 2.02

import sys

def round(n):
    ROUND_FACTOR = 10000
    result = int(n*ROUND_FACTOR+0.5)/ROUND_FACTOR
    if int(result)==result:
        result = int(result)
    return result

n, k = int(sys.argv[1]), int(sys.argv[2])
print(round(k ** (1/n)))
