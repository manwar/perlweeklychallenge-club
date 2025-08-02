#!/usr/bin/env python3

# Challenge 159
#
# TASK #1 > Farey Sequence
# Submitted by: Mohammad S Anwar
# You are given a positive number, $n.
#
# Write a script to compute Farey Sequence of the order $n.
#
# Example 1:
# Input: $n = 5
# Output: 0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1.
# Example 2:
# Input: $n = 7
# Output: 0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7, 3/5, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 1/1.
# Example 3:
# Input: $n = 4
# Output: 0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1.

from math import gcd
import sys

def farey_sequence(n):
    seq = [(0, 1), (1, 1)]  # first and last terms

    for i in range(1, n + 1):
        for j in range(i + 1, n + 1):
            if gcd(i, j) == 1:
                seq.append((i, j))

    seq.sort(key=lambda x: x[0] / x[1])
    seq = [f"{num[0]}/{num[1]}" for num in seq]

    return seq

n = int(sys.argv[1])
print(", ".join(farey_sequence(n)))
