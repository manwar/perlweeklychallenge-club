#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-238/#TASK1
#
# Task 1: Running Sum
# ===================
#
# You are given an array of integers.
#
# Write a script to return the running sum of the given array. The running sum
# can be calculated as sum[i] = num[0] + num[1] + …. + num[i].
#
## Example 1
##
## Input: @int = (1, 2, 3, 4, 5)
## Output: (1, 3, 6, 10, 15)
#
## Example 2
##
## Input: @int = (1, 1, 1, 1, 1)
## Output: (1, 2, 3, 4, 5)
#
## Example 3
##
## Input: @int = (0, -1, 1, 2)
## Output: (0, -1, 0, 2)
#
############################################################
##
## discussion
##
############################################################
#
# This one is straight forward: For each element, add it to
# the current sum and add the sum to the result array.


def running_sum(ints: list):
    sum = 0
    result = []
    print("Input: (", ", ".join(str(x) for x in ints), ")")
    for elem in ints:
        sum += elem
        result.append(sum)
    print("Output: (", ", ".join(str(x) for x in result), ")")


running_sum([1, 2, 3, 4, 5])
running_sum([1, 1, 1, 1, 1])
running_sum([0, -1, 1, 2])
