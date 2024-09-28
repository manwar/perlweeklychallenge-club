#!/usr/bin/env python3

# Challenge 156
#
# TASK #1 > Pernicious Numbers
# Submitted by: Mohammad S Anwar
# Write a script to permute first 10 Pernicious Numbers.
#
# A pernicious number is a positive integer which has prime number of ones in
# its binary representation.
#
# The first pernicious number is 3 since binary representation of 3 = (11)
# and 1 + 1 = 2, which is a prime.
#
# Expected Output
# 3, 5, 6, 7, 9, 10, 11, 12, 13, 14

from sympy import isprime

def is_pernicious(n):
    bin_n = bin(n)[2:]  # Convert to binary and remove the '0b' prefix
    ones = bin_n.count('1')
    is_pernicious = isprime(ones)
    return is_pernicious

def first_pernicious(num):
    out = []
    n = 0
    while len(out) < num:
        if is_pernicious(n):
            out.append(n)
        n += 1
    return out

print(", ".join(map(str, first_pernicious(10))))
