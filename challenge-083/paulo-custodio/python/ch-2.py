#!/usr/bin/env python3

# Challenge 083
#
# TASK #2 > Flip Array
# Submitted by: Mohammad S Anwar
# You are given an array @A of positive numbers.
#
# Write a script to flip the sign of some members of the given array so that
# the sum of the all members is minimum non-negative.
#
# Given an array of positive elements, you have to flip the sign of some of
# its elements such that the resultant sum of the elements of array should be
# minimum non-negative(as close to zero as possible). Return the minimum no. of
# elements whose sign needs to be flipped such that the resultant sum is minimum
# non-negative.
#
# Example 1:
# Input: @A = (3, 10, 8)
# Output: 1
# Explanation:
# Flipping the sign of just one element 10 gives the result 1 i.e.
# (3) + (-10) + (8) = 1
# Example 2:
# Input: @A = (12, 2, 10)
# Output: 1
# Explanation:
# Flipping the sign of just one element 12 gives the result 0 i.e.
# (-12) + (2) + (10) = 0

import sys

def sumprod(a, b):
    sum = 0
    for i in range(len(a)):
        sum += a[i]*b[i]
    return sum

# odometer-style sign flipper
def next_flip(sign):
    for i in range(len(sign)):
        if sign[i]==1:
            sign[i]=-1
            return True
        else:
            sign[i]=1
    return False

def count_flips(a):
    # setup initial conditions
    sign = [1 for x in a]
    min_flips = 0
    min_sum = sumprod(a, sign)

    while next_flip(sign):
        sum = sumprod(a, sign)
        if sum >= 0:
            flips = len(list(filter(lambda x: x==-1, sign)))
            if sum < min_sum or (sum == min_sum and flips < min_flips):
                min_sum, min_flips = sum, flips
    return min_flips

print(count_flips([int(x) for x in sys.argv[1:]]))
