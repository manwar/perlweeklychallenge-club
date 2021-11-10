#!/usr/bin/env python3

# Challenge 089

# TASK #1 > GCD Sum
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to sum GCD of all possible unique pairs between 1 and $N.

# This solution uses a recursive algorithm to compute the GCD.

import sys

def gcd(a, b):
    if a==0:
        return b
    else:
        return gcd(b%a, a)

def sum_gcd(n):
    sum = 0
    for a in range(1, n):
        for b in range(a+1, n+1):
            sum += gcd(a, b)
    return sum

print(sum_gcd(int(sys.argv[1])))
