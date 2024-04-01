#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263/#TASK1
#
# Task 1: Target Index
# ====================
#
# You are given an array of integers, @ints and a target element $k.
#
# Write a script to return the list of indices in the sorted array where the
# element is same as the given target element.
#
## Example 1
##
## Input: @ints = (1, 5, 3, 2, 4, 2), $k = 2
## Output: (1, 2)
##
## Sorted array: (1, 2, 2, 3, 4, 5)
## Target indices: (1, 2) as $ints[1] = 2 and $k[2] = 2
#
## Example 2
##
## Input: @ints = (1, 2, 4, 3, 5), $k = 6
## Output: ()
##
## No element in the given array matching the given target.
#
## Example 3
##
## Input: @ints = (5, 3, 2, 4, 2, 1), $k = 4
## Output: (4)
##
## Sorted array: (1, 2, 2, 3, 4, 5)
## Target index: (4) as $ints[4] = 4
#
############################################################
##
## discussion
##
############################################################
#
# Straight forward steps: sort the input array, use an index to
# walk the array and remember the instances where $ints[$i] == $k.

def target_index(ints: list, k: int) -> None:
    print("Input: (", ", ".join(str(x) for x in ints), ")", sep="")
    result = []
    sorted_ints = sorted(ints)
    for i in range(len(sorted_ints)):
        if sorted_ints[i] == k:
            result.append(i)
    print("Output: (", ", ".join(str(x) for x in result), ")", sep="")

target_index( [1, 5, 3, 2, 4, 2], 2);
target_index( [1, 2, 4, 3, 5], 6);
target_index( [5, 3, 2, 4, 2, 1], 4);

