#!/usr/bin/env python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-249/#TASK1
#
# Task 1: Shortest Distance
# =========================
#
# You are given an array of integers with even number of elements.
#
# Write a script to divide the given array into equal pairs such that:
#
# a) Each element belongs to exactly one pair.
# b) The elements present in a pair are equal.
#
#
## Example 1
##
## Input: @ints = (3, 2, 3, 2, 2, 2)
## Output: (2, 2), (3, 3), (2, 2)
##
## There are 6 elements in @ints.
## They should be divided into 6 / 2 = 3 pairs.
## @ints is divided into the pairs (2, 2), (3, 3), and (2, 2) satisfying all the
## conditions.
#
## Example 2
##
## Input: @ints = (1, 2, 3, 4)
## Output: ()
##
## There is no way to divide @ints 2 pairs such that the pairs satisfy every
## condition.
#
############################################################
##
## discussion
##
############################################################
#
# We use the elements of the array as keys for a hash in which we
# count the amount of elements of this value in the array.
# If in the end, all values in the hash are even, we can spit out the
# correct number of arrays, otherwise we can only return an empty array.

def shortest_distance(ints: list) -> list:
    print("Input: (", ", ".join([str(x) for x in ints]), ")")
    result = []
    map = {}
    for i in ints:
        if i in map:
            map[i] += 1
        else:
            map[i] = 1
    for key in map.keys():
        if map[key] % 2 != 0:
            print("Output: ()")
            return ()
        i = int( map[key] / 2 )
        for j in range(1,i+1):
            result.append( [key, key] )
    first = True
    print("Output: ", end="")
    for elem in result:
        if first:
            first = False
        else:
            print(", ", end="")
        print(", ".join([str(x) for x in elem]), end="")
    print("")

shortest_distance([3, 2, 3, 2, 2, 2])
shortest_distance([1, 2, 3, 4])

