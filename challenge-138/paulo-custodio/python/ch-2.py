#!/usr/bin/env python3

# Challenge 138
#
# TASK #2 > Split Number
# Submitted by: Mohammad S Anwar
# You are given a perfect square.
#
# Write a script to figure out if the square root the given number is same as
# sum of 2 or more splits of the given number.
#
# Example 1
# Input: $n = 81
# Output: 1
#
# Since, sqrt(81) = 8 + 1
# Example 2
# Input: $n = 9801
# Output: 1
#
# Since, sqrt(9801) = 98 + 0 + 1
# Example 3
# Input: $n = 36
# Output: 0
#
# Since, sqrt(36) != 3 + 6

import sys
import math

def get_splits(n):
    splits = []

    def add_splits(path, rest):
        nonlocal splits

        if rest=="":
            splits.append(path)
        else:
            for i in range(1, len(rest)+1):
                a = rest[0:i]
                b = rest[i:]
                add_splits([*path, int(a)], b)

    add_splits([], str(n))
    return splits

def sqroot_is_sum_splits(n):
    sq = math.sqrt(n)
    if int(sq)!=sq:
        return False        # not perfect square
    for split in get_splits(n):
        if sum(split)==int(sq):
            return True
    return False

if sqroot_is_sum_splits(int(sys.argv[1])):
    print(1)
else:
    print(0)
