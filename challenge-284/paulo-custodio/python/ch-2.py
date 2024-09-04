#!/usr/bin/env python3

# Challenge 284
#
# Task 2: Relative Sort
# Submitted by: Mohammad Sajid Anwar
#
# You are given two list of integers, @list1 and @list2. The elements in the
# @list2 are distinct and also in the @list1.
#
# Write a script to sort the elements in the @list1 such that the relative
# order of items in @list1 is same as in the @list2. Elements that is missing
# in @list2 should be placed at the end of @list1 in ascending order.
# Example 1
#
# Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
#        @list2 = (2, 1, 4, 3, 5, 6)
# Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)
#
# Example 2
#
# Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
#        @list2 = (1, 3, 2)
# Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)
#
# Example 3
#
# Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
#        @list2 = (1, 0, 3, 2)
# Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)

import sys

args = (" ".join(sys.argv[1:])).split(',')
list1 = [int(x) for x in args[0].split()]
list2 = [int(x) for x in args[1].split()]

output = []
while len(list2) > 0:
    n = list2[0]
    list2 = list2[1:]
    for x in filter(lambda x:x == n, list1):
        output.append(x)
    list1 = list(filter(lambda x:x != n, list1))
for x in sorted(list1):
    output.append(x)

print(", ".join([str(x) for x in output]))
