#!/usr/bin/env python3

# Challenge 059
#
# TASK #2 > Bit Sum
# Reviewed by Ryan Thompson
# Helper Function
# For this task, you will most likely need a function f(a,b) which returns the
# count of different bits of binary representation of a and b.
#
# For example, f(1,3) = 1, since:
#
# Binary representation of 1 = 01
#
# Binary representation of 3 = 11
#
# There is only 1 different bit. Therefore the subroutine should return 1. Note
# that if one number is longer than the other in binary, the most significant
# bits of the smaller number are padded (i.e., they are assumed to be zeroes).
#
# Script Output
# You script should accept n positive numbers. Your script should sum the result
# of f(a,b) for every pair of numbers given:
#
# For example, given 2, 3, 4, the output would be 6,
# since f(2,3) + f(2,4) + f(3,4) = 1 + 2 + 3 = 6

import sys
from itertools import combinations

def f(a, b):
    r = int(a) ^ int(b)
    rt = bin(r)
    return rt.count('1')

n = list(map(int, sys.argv[1:]))
sum_ = 0

for combin in combinations(n, 2):
    sum_ += f(combin[0], combin[1])

print(sum_)
