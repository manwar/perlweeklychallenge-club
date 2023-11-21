#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-244/#TASK2
#
# Task 2: Group Hero
# ==================
#
# You are given an array of integers representing the strength.
#
# Write a script to return the sum of the powers of all possible combinations;
# power is defined as the square of the largest number in a sequence,
# multiplied by the smallest.
#
## Example 1
##
## Input: @nums = (2, 1, 4)
## Output: 141
##
## Group 1: (2) => square(max(2)) * min(2) => 4 * 2 => 8
## Group 2: (1) => square(max(1)) * min(1) => 1 * 1 => 1
## Group 3: (4) => square(max(4)) * min(4) => 16 * 4 => 64
## Group 4: (2,1) => square(max(2,1)) * min(2,1) => 4 * 1 => 4
## Group 5: (2,4) => square(max(2,4)) * min(2,4) => 16 * 2 => 32
## Group 6: (1,4) => square(max(1,4)) * min(1,4) => 16 * 1 => 16
## Group 7: (2,1,4) => square(max(2,1,4)) * min(2,1,4) => 16 * 1 => 16
##
## Sum: 8 + 1 + 64 + 4 + 32 + 16 + 16 => 141
#
############################################################
##
## discussion
##
############################################################
#
# Iterating over all subsets of the @nums array, we calculate both the
# minimum and maximum value of the elements therin. Then we just need
# to calculate the sum of the minimum and the square of the maximum and
# in the end sum up all of these.
# First we define a powerset function which can be found here:
# https://towardsdatascience.com/the-subsets-powerset-of-a-set-in-python-3-18e06bd85678
# Then we walk the powerset, calculating the result for each subset on
# the fly and adding those results to the final result on the go.

from itertools import chain, combinations

def powerset(iterable):
    "powerset([1,2,3]) → () (1,) (2,) (3,) (1,2) (1,3) (2,3) (1,2,3)"
    s = list(iterable)
    return chain.from_iterable(combinations(s, r) for r in range(len(s)+1))

def min_max_squared(nums: list) -> float:
    elems = len(nums)
    if elems == 0:
        return 0
    min = nums[0]
    max = nums[0]
    for elem in nums:
        if elem > max:
            max = elem
        if elem < min:
            min = elem
    return min * max * max

def group_hero(nums: list):
    print("Input: (", ", ".join(str(x) for x in nums), ")")
    result = 0
    for s in powerset(nums):
        result += min_max_squared(list(s))
    print(f"Output: {result}")

group_hero([2, 1, 4]);
group_hero([]);
group_hero([1, 2]);
