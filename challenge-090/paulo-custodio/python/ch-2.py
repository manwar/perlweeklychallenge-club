#!/usr/bin/env python

# Challenge 090
#
# TASK #2 > Ethiopian Multiplication
# Submitted by: Mohammad S Anwar
# You are given two positive numbers $a and $b.
#
# Write a script to demonstrate Ethiopian Multiplication using the given numbers.

import sys

def mul(a,b):
    mul = 0
    while True:
        if (a & 1) != 0:
            mul += b
        if a <= 1:
            break
        a >>= 1
        b <<= 1
    return mul

print(mul(int(sys.argv[1]), int(sys.argv[2])))
