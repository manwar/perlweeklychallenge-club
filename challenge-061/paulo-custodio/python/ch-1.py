#!/usr/bin/env perl

# Challenge 061
#
# TASK #1 > Product SubArray
# Reviewed by: Ryan Thompson
# Given a list of 4 or more numbers, write a script to find the contiguous
# sublist that has the maximum product. The length of the sublist is irrelevant;
# your job is to maximize the product.
#
# Example
# Input: [ 2, 5, -1, 3 ]
#
# Output: [ 2, 5 ] which gives maximum product 10.

import sys

def product(nums):
    prod = 1
    for x in nums:
        prod *= x
    return x


n = list(map(int, sys.argv[1:]))
max_sublist = []
max_prod = int(-1e6)

for i in range(0, len(n)):
    for j in range(i, len(n)):
        sublist = n[i:j+1]
        prod = product(sublist)
        if prod > max_prod:
            max_sublist, max_prod = sublist, prod

print(", ".join(list(map(str, max_sublist))))
