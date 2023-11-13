#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-243/#TASK2
#
# Task 2: Floor Sum
# =================
#
# You are given an array of positive integers (>=1).
#
# Write a script to return the sum of floor(nums[i] / nums[j]) where
# 0 <= i,j < nums.length. The floor() function returns the integer part
# of the division.
#
## Example 1
##
## Input: @nums = (2, 5, 9)
## Output: 10
##
## floor(2 / 5) = 0
## floor(2 / 9) = 0
## floor(5 / 9) = 0
## floor(2 / 2) = 1
## floor(5 / 5) = 1
## floor(9 / 9) = 1
## floor(5 / 2) = 2
## floor(9 / 2) = 4
## floor(9 / 5) = 1
#
## Example 2
##
## Input: @nums = (7, 7, 7, 7, 7, 7, 7)
## Output: 49
#
############################################################
##
## discussion
##
############################################################
#
# Sum up the calculated floor(nums[i]/nums[$j]) for all combinations.

def floor_sum(nums: list):
   result = 0
   print("Input: (", ", ".join(str(x) for x in nums), ")")
   for i in range(len(nums)):
       for j in range(len(nums)):
           result += int(nums[i] / nums[j])
   print("Output:", str(result))

floor_sum( [ 2, 5, 9 ] );
floor_sum( [ 7, 7, 7, 7, 7, 7, 7 ] );

