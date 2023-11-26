#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-242/#TASK1
#
# Task 1: Missing Members
# =======================
#
# You are given two arrays of integers.
#
# Write a script to find out the missing members in each other arrays.
#
## Example 1
##
## Input: @arr1 = (1, 2, 3)
##        @arr2 = (2, 4, 6)
## Output: ([1, 3], [4, 6])
##
## (1, 2, 3) has 2 members (1, 3) missing in the array (2, 4, 6).
## (2, 4, 6) has 2 members (4, 6) missing in the array (1, 2, 3).
#
## Example 2
##
## Input: @arr1 = (1, 2, 3, 3)
##        @arr2 = (1, 1, 2, 2)
## Output: ([3])
##
## (1, 2, 3, 3) has 2 members (3, 3) missing in the array (1, 1, 2, 2). Since they are same, keep just one.
## (1, 1, 2, 2) has 0 member missing in the array (1, 2, 3, 3).
#
############################################################
##
## discussion
##
############################################################
#
# For each element of each array, if it is not in the other array,
# save it for the output.
# Example 2 has a caveat though, by not returning an empty array in
# case of no missing elements it is unclear in which of the arrays
# the element was originally. It's better to return an empty array
# here, so let's just do that instead.

def missing_members(arr1: list, arr2: list):
    seen: dict = {}
    res1: list = []
    res2: list = []
    print("Input: ([", ", ".join(str(x) for x in arr1), "], [", ", ".join(str(x) for x in arr2), "])")
    for elem in arr1:
        if elem in seen:
            next
        else:
            if elem not in arr2:
                seen[elem] = 1
                res1.append(elem)
    seen = {}
    for elem in arr2:
        if elem in seen:
            next
        else:
            if elem not in arr1:
                seen[elem] = 1
                res2.append(elem)
    print("Output: ([", ", ".join(str(x) for x in res1), "], [", ", ".join(str(x) for x in res2), "])")

missing_members( [ 1, 2, 3 ], [ 2, 4, 6 ] );
missing_members( [ 1, 2, 3, 3 ], [ 1, 1, 2, 2 ] );

