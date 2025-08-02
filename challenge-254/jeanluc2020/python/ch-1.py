#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-254/#TASK1
#
# Task 1: Three Power
# ===================
#
# You are given a positive integer, $n.
#
# Write a script to return true if the given integer is a power of three
# otherwise return false.
#
## Example 1
##
## Input: $n = 27
## Output: true
##
## 27 = 3 ^ 3
#
## Example 2
##
## Input: $n = 0
## Output: true
##
## 0 = 0 ^ 3
#
## Example 3
##
## Input: $n = 6
## Output: false
#
############################################################
##
## discussion
##
############################################################
#
# Starting with $i at 0, count up to $n. If $i**3 == $n we have
# a third power, so return true. If $i**3 > $n we don't have a
# third power, so return false.
#

def three_power(n: int) -> None:
    print(f"Input: {n}")
    for i in range(n+1):
        if i**3 == n:
            print("Output: true")
            return
        if i**3 > n:
            print("Output: false")
            return

three_power(27);
three_power(0);
three_power(6);

