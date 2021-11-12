#!/usr/bin/env python3

# Challenge 082
#
# TASK #1 > Common Factors
# Submitted by: Niels van Dijke
# You are given 2 positive numbers $M and $N.
#
# Write a script to list all common factors of the given numbers.
#
# Example 1:
# Input:
#     $M = 12
#     $N = 18
#
# Output:
#     (1, 2, 3, 6)
#
# Explanation:
#     Factors of 12: 1, 2, 3, 4, 6
#     Factors of 18: 1, 2, 3, 6, 9
# Example 2:
# Input:
#     $M = 18
#     $N = 23
#
# Output:
#     (1)
#
# Explanation:
#     Factors of 18: 1, 2, 3, 6, 9
#     Factors of 23: 1

import sys

def get_common_factors(a, b):
    factors = []
    i = 1
    while i <= a or i <= b:
        if a%i==0 and b%i==0:
            factors.append(i)
        i += 1
    return factors

factors = get_common_factors(int(sys.argv[1]), int(sys.argv[2]))
print("("+ ", ".join([str(x) for x in factors]) +" )")
