#!/usr/bin/env python3

# Challenge 126
#
# TASK #1 > Count Numbers
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to print count of numbers from 1 to $N that don't contain digit 1.
#
# Example
# Input: $N = 15
# Output: 8
#
#     There are 8 numbers between 1 and 15 that don't contain digit 1.
#     2, 3, 4, 5, 6, 7, 8, 9.
#
# Input: $N = 25
# Output: 13
#
#     There are 13 numbers between 1 and 25 that don't contain digit 1.
#     2, 3, 4, 5, 6, 7, 8, 9, 20, 22, 23, 24, 25.

import sys
import re

N = int(sys.argv[1])
count = 0
for n in range(1, N+1):
    if not re.search(r"1", str(n)):
        count += 1
print(count)
