#!/usr/bin/env python3

# Challenge 183
#
# Task 1: Unique Array
# Submitted by: Mohammad S Anwar
#
# You are given list of arrayrefs.
#
# Write a script to remove the duplicate arrayrefs from the given list.
# Example 1
#
# Input: @list = ([1,2], [3,4], [5,6], [1,2])
# Output: ([1,2], [3,4], [5,6])
#
# Example 2
#
# Input: @list = ([9,1], [3,7], [2,5], [2,5])
# Output: ([9, 1], [3,7], [2,5])

def remove_dups(a):
    seen = set()
    a = [x for x in a if tuple(x) not in seen and not seen.add(tuple(x))]
    return a

import sys

in_data = [list(map(int, item.split(','))) for item in sys.argv[1:]]
out_data = remove_dups(in_data)
print("(", ", ".join([f"[{','.join(map(str, item))}]" for item in out_data]), ")", sep="")
