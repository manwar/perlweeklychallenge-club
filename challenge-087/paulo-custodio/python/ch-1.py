#!/usr/bin/env python3

# Challenge 087
#
# TASK #1 > Longest Consecutive Sequence
# Submitted by: Mohammad S Anwar
# You are given an unsorted array of integers @N.
#
# Write a script to find the longest consecutive sequence. Print 0 if none sequence found.
#
# Example 1:
# Input: @N = (100, 4, 50, 3, 2)
# Output: (2, 3, 4)
# Example 2:
# Input: @N = (20, 30, 10, 40, 50)
# Output: 0
# Example 3:
# Input: @N = (20, 19, 9, 11, 10)
# Output: (9, 10, 11)

import sys

def longest_seq(n):
    seq = []

    # sort the sequence
    n.sort()

    # look for sequences of consecutive numbers
    while len(n) > 0:
        i = 0
        while i < len(n) and n[i]==n[0]+i:
            i += 1
        got = n[:i]
        n = n[i:]
        if len(got) > 1 and len(got) > len(seq):
            seq = got

    return seq

seq = longest_seq([int(x) for x in sys.argv[1:]])
if seq:
    print("("+ ", ".join([str(x) for x in seq]) +")")
else:
    print(0)
