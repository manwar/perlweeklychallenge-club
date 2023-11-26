#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-241/#TASK1
#
# Task 1: Arithmetic Triplets
# ===========================
#
# You are given an array (3 or more members) of integers in increasing order
# and a positive integer.
#
# Write a script to find out the number of unique Arithmetic Triplets
# satisfying the following rules:
#
# a) i < j < k
# b) nums[j] - nums[i] == diff
# c) nums[k] - nums[j] == diff
#
## Example 1
##
## Input: @nums = (0, 1, 4, 6, 7, 10)
##        $diff = 3
## Output: 2
##
## Index (1, 2, 4) is an arithmetic triplet because both  7 - 4 == 3 and 4 - 1 == 3.
## Index (2, 4, 5) is an arithmetic triplet because both 10 - 7 == 3 and 7 - 4 == 3.
#
## Example 2
##
## Input: @nums = (4, 5, 6, 7, 8, 9)
##        $diff = 2
## Output: 2
##
## (0, 2, 4) is an arithmetic triplet because both 8 - 6 == 2 and 6 - 4 == 2.
## (1, 3, 5) is an arithmetic triplet because both 9 - 7 == 2 and 7 - 5 == 2.
#
############################################################
##
## discussion
##
############################################################
#
# Looping over the indices i, j, k we just check the condition.
# We can even short-curcuit the inner loop because we only need
# to execute it if $nums[$j] - $nums[$i] == $diff.


def arithmetic_triplets(nums: list, diff: int):
    print("Input: (", ", ".join(str(x) for x in nums), "), ", diff, sep="")
    result = 0
    for i in range(len(nums)):
        for j in range(i+1, len(nums)):
            if nums[j] - nums[i] == diff:
                for k in range(j+1, len(nums)):
                    if nums[k] - nums[j] == diff:
                        result += 1
    print("Output:", result)

arithmetic_triplets( [0, 1, 4, 6, 7, 10], 3 );
arithmetic_triplets( [4, 5, 6, 7, 8, 9], 2);


