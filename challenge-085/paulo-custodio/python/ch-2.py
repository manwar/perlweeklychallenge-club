#!/usr/bin/env python3

# Challenge 085
#
# TASK #2 > Power of Two Integers
# Submitted by: Mohammad S Anwar
# You are given a positive integer $N.
#
# Write a script to find if it can be expressed as a ** b where
# a > 0 and b > 1. Print 1 if you succeed otherwise 0.
#
# Example 1:
# Input: 8
# Output: 1 as 8 = 2 ** 3
# Example 2:
# Input: 15
# Output: 0
# Example 3:
# Input: 125
# Output: 1 as 125 = 5 ** 3

import sys

def get_prime_factors(n):
    i = 2
    prime_factors = []
    while i*i <= n:
        if n%i == 0:
            prime_factors.append(i)
            n //= i
        else:
            i += 1

    if n>1:
        prime_factors.append(n)

    return prime_factors

def is_perfect_power(n):
    factors = list(set(get_prime_factors(n)))
    return len(factors)==1

print(1 if is_perfect_power(int(sys.argv[1])) else 0)
