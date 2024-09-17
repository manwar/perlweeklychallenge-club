#!/usr/bin/env python3

# Challenge 060
#
# TASK #2 > Find Numbers
# Reviewed by: Ryan Thompson
# Write a script that accepts list of positive numbers (@L) and two positive
# numbers $X and $Y.
#
# The script should print all possible numbers made by concatenating the numbers
# from @L, whose length is exactly $X but value is less than $Y.
#
# Example
# Input:
#
# @L = (0, 1, 2, 5);
# $X = 2;
# $Y = 21;
# Output:
#
# 10, 11, 12, 15, 20

import sys

def combine1(combin, prefix, n, digits):
    if len(prefix) == n:
        num = int(prefix)
        if not num in combin:
            combin.add(num)
    else:
        for digit in digits:
            combine1(combin, prefix+digit, n, digits)

def combine(digits):
    combin = set()
    for n in range(1, len(digits)+1):
        combine1(combin, "", n, digits)
    nums = sorted(list(combin))
    return nums

def numbers(X, Y, L):
    nums = combine(L)
    nums = list(filter(lambda x:len(str(x))==X and x<Y, nums))
    return nums

X = int(sys.argv[1])
Y = int(sys.argv[2])
L = sys.argv[3:]
nums = numbers(X, Y, L)
print(", ".join(map(str, nums)))
