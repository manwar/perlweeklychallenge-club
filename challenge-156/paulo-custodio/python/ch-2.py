#!/usr/bin/env python3

# Challenge 156
#
# TASK #2 > Weird Number
# Submitted by: Mohammad S Anwar
# You are given number, $n > 0.
#
# Write a script to find out if the given number is a Weird Number.
#
# According to Wikipedia, it is defined as:
#
# The sum of the proper divisors (divisors including 1 but not itself) of the
# number is greater than the number, but no subset of those divisors sums to
# the number itself.
#
# Example 1:
# Input: $n = 12
# Output: 0
#
# Since the proper divisors of 12 are 1, 2, 3, 4, and 6, which sum to 16; but
# 2 + 4 + 6 = 12.
# Example 2:
# Input: $n = 70
# Output: 1
#
# As the proper divisors of 70 are 1, 2, 5, 7, 10, 14, and 35; these sum to
# 74, but no subset of these sums to 70.

import sys
from itertools import combinations
from math import isqrt

def divisors(n):
    divs = set()
    for i in range(1, isqrt(n) + 1):
        if n % i == 0:
            divs.add(i)
            divs.add(n // i)
    return divs

def proper_divisors(n):
    return [d for d in divisors(n) if d != n]

def check_no_subset_sums_n(n, div):
    for k in range(1, len(div) + 1):
        for combin in combinations(div, k):
            if sum(combin) == n:
                return False
    return True

def is_weird(n):
    div = proper_divisors(n)
    if sum(div) <= n:
        return False
    return check_no_subset_sums_n(n, div)

n = int(sys.argv[1])
print(1 if is_weird(n) else 0)
