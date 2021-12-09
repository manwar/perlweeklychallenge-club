#!/usr/bin/python3

# Challenge 078
#
# TASK #1 > Leader Element
# Submitted by: Mohammad S Anwar
# You are given an array @A containing distinct integers.
#
# Write a script to find all leader elements in the array @A. Print (0) if
# none found.
#
# An element is leader if it is greater than all the elements to its right
# side.
#
# Example 1:
# Input: @A = (9, 10, 7, 5, 6, 1)
# Output: (10, 7, 6, 1)
# Example 2:
# Input: @A = (3, 4, 5)
# Output: (5)

import sys

def find_leaders(a):
    leaders = []
    cur_max = 0
    for i in range(len(a))[::-1]:
        if a[i] > cur_max:
            leaders.insert(0, a[i])
            cur_max = a[i]
    if len(leaders)==0:
        leaders = [0]
    return leaders

leaders = find_leaders([int(x) for x in sys.argv[1:]])
print("("+", ".join([str(x) for x in leaders])+")")
