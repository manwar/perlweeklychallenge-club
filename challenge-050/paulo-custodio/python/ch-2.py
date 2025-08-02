#!/usr/bin/env python3

# Challenge 050
#
# TASK #2
# Contributed by Ryan Thompson.
# Noble Integer
# You are given a list, @L, of three or more random integers between 1 and 50.
# A Noble Integer is an integer N in @L, such that there are exactly N integers
# greater than N in @L. Output any Noble Integer found in @L, or an empty list
# if none were found.
#
# An interesting question is whether or not there can be multiple Noble Integers
# in a list.
#
# For example,
#
# Suppose we have list of 4 integers [2, 6, 1, 3].
#
# Here we have 2 in the above list, known as Noble Integer, since there are
# exactly 2 integers in the list i.e.3 and 6, which are greater than 2.
#
# Therefore the script would print 2.

import sys

def noble_int(nums):
    out = []
    for n in nums:
        num_greater = len([x for x in filter(lambda x: x > n, nums)])
        if num_greater == n:
            out.append(n)
    return out

nums = [int(x) for x in range(1, len(sys.argv))]
noble = noble_int(nums)
print("("+", ".join(str(x) for x in noble)+")")
