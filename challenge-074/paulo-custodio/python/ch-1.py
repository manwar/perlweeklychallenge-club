#!/usr/bin/env python3

# Challenge 074
#
# TASK #1 > Majority Element
# Submitted by: Mohammad S Anwar
# You are given an array of integers of size $N.
#
# Write a script to find the majority element. If none found then print -1.
#
# Majority element in the list is the one that appears more than
# floor(size_of_list/2).
#
# Example 1
# Input: @A = (1, 2, 2, 3, 2, 4, 2)
# Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).
#
# Example 2
# Input: @A = (1, 3, 1, 2, 4, 5)
# Output: -1 as none of the elements appears more than floor(6/2).

import sys

def majority_elem(a):
    # count instances of each element, get max
    count = {}
    max_count = 0
    max_elem = None
    for x in a:
        if x in count:
            count[x] += 1
        else:
            count[x] = 1

        if count[x] > max_count:
            max_count, max_elem = count[x], x

    # check if majority
    if max_count > int(len(a)/2):
        return max_elem
    else:
        return -1

a = [int(x) for x in sys.argv[1:]]
print(majority_elem(a))
