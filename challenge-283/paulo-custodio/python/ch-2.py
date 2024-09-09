#!/usr/bin/env python3

# Challenge 283
#
# Task 2: Digit Count Value
# Submitted by: Mohammad Sajid Anwar
#
# You are given an array of positive integers, @ints.
#
# Write a script to return true if for every index i in the range 0 <= i < size
# of array, the digit i occurs exactly the $ints[$i] times in the given array
# otherwise return false.
# Example 1
#
# Input: @ints = (1, 2, 1, 0)
# Ouput: true
#
# $ints[0] = 1, the digit 0 occurs exactly 1 time.
# $ints[1] = 2, the digit 1 occurs exactly 2 times.
# $ints[2] = 1, the digit 2 occurs exactly 1 time.
# $ints[3] = 0, the digit 3 occurs 0 time.
#
# Example 2
#
# Input: @ints = (0, 3, 0)
# Ouput: false
#
# $ints[0] = 0, the digit 0 occurs 2 times rather than 0 time.
# $ints[1] = 3, the digit 1 occurs 0 time rather than 3 times.
# $ints[2] = 0, the digit 2 occurs exactly 0 time.

import sys

def digit_count_true(ints):
    count = {}
    for i in range(len(ints)):
        count[i] = 0
    for x in ints:
        if x in count:
            count[x] += 1
        else:
            count[x] = 1
    for i in range(len(ints)):
        if count[i] != ints[i]:
            return False
    return True

ints = [int(x) for x in sys.argv[1:]]
print('true' if digit_count_true(ints) else 'false')
