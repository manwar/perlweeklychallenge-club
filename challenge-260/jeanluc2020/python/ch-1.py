#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-260/#TASK1
#
# Task 1: Unique Occurrences
# ==========================
#
# You are given an array of integers, @ints.
#
# Write a script to return 1 if the number of occurrences of each value in the
# given array is unique or 0 otherwise.
#
## Example 1
##
## Input: @ints = (1,2,2,1,1,3)
## Output: 1
##
## The number 1 occurred 3 times.
## The number 2 occurred 2 times.
## The number 3 occurred 1 time.
##
## All occurrences are unique, therefore the output is 1.
#
## Example 2
##
## Input: @ints = (1,2,3)
## Output: 0
#
## Example 3
##
## Input: @ints = (-2,0,1,-2,1,1,0,1,-2,9)
## Output: 1
#
############################################################
##
## discussion
##
############################################################
#
# First, we calculate how often each value occurs in @ints and
# store that information in a $map. Then we check if all values
# in $map are unique: if we find one that isn't, we can set
# $unique to 0.

def unique_occurrences(ints: list) -> None:
    print("Input: (", ", ".join(str(x) for x in ints), ")", sep="")
    map: dict = {}
    for i in ints:
        if i in map:
            map[i] += 1
        else:
            map[i] = 1
    seen: dict = {}
    unique = 1
    for key in map:
        if map[key] in seen:
            unique = 0
        seen[map[key]] = 1
    print(f"Output: {unique}")

unique_occurrences([1,2,2,1,1,3]);
unique_occurrences([1,2,3]);
unique_occurrences([-2,0,1,-2,1,1,0,1,-2,9]);

