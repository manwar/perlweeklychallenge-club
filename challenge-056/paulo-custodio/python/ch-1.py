#!/usr/bin/env python3

# Challenge 056
#
# TASK #1
# Diff-K
# You are given an array @N of positive integers (sorted) and another non
# negative integer k.
#
# Write a script to find if there exists 2 indices i and j such that
# A[i] - A[j] = k and i != j.
#
# It should print the pairs of indices, if any such pairs exist.
#
# Example:
#
#     @N = (2, 7, 9)
#     $k = 2
# Output : 2,1

import sys

k = int(sys.argv[1])
n = [int(x) for x in sys.argv[2:]]

for i in range(0, len(n)-1):
    for j in range(i+1, len(n)):
        if abs(n[i]-n[j]) == k:
            print(str(i)+","+str(j))
