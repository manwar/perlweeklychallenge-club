#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-262/#TASK1
#
# Task 1: Max Positive Negative
# =============================
#
# You are given an array of integers, @ints.
#
# Write a script to return the maximum number of either positive or negative
# integers in the given array.
#
## Example 1
##
## Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
## Output: 4
##
## Count of positive integers: 4
## Count of negative integers: 3
## Maximum of count of positive and negative integers: 4
#
## Example 2
##
## Input: @ints = (-1, -2, -3, 1)
## Output: 3
##
## Count of positive integers: 1
## Count of negative integers: 3
## Maximum of count of positive and negative integers: 3
#
## Example 3
##
## Input: @ints = (1,2)
## Output: 2
##
## Count of positive integers: 2
## Count of negative integers: 0
## Maximum of count of positive and negative integers: 2
#
############################################################
##
## discussion
##
############################################################
#
# Simply count the negatives and the positives, then return
# the bigger of the two numbers.

def max_positive_negative(ints: list) -> None:
    print("Input: (", ", ".join(str(x) for x in ints), ")", sep="")
    pos = 0
    neg = 0
    for num in ints:
        if num < 0:
            neg += 1
        else:
            pos += 1
    result = pos if pos > neg else neg
    print(f"Output: {result}")

max_positive_negative([-3, 1, 2, -1, 3, -2, 4]);
max_positive_negative([-1, -2, -3, 1]);
max_positive_negative([1,2]);

