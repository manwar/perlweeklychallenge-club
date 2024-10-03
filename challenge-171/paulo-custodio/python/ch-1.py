#!/usr/bin/env python3

# Challenge 171
#
# Task 1: Abundant Number
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Abundant Odd Numbers.
#
# According to wikipedia,
#
#     A number n for which the sum of divisors s(n) > 2n, or, equivalently, the
#     sum of proper divisors (or aliquot sum) s(n) > n.
#
#
# For example, 945 is the first Abundant Odd Number.
#
# Sum of divisors:
# 1 + 3 + 5 + 7 + 9 + 15 + 21 + 27 + 35 + 45 + 63 + 105 + 135 + 189 + 315 = 975

import sys
import math
from functools import reduce

def divisors(n):
    div_low = []
    div_high = []
    for i in range(1, int(math.sqrt(n)) + 1):
        if n % i == 0:
            div_low.append(i)
            if n // i != i:
                div_high.insert(0, n // i)
    return div_low + div_high

def proper_divisors(n):
    div = divisors(n)
    return div[:-1]

def is_abundant(n):
    return sum(proper_divisors(n)) > n

def abundant_numbers(N):
    abundant = []
    n = 1
    while len(abundant) < N:
        if is_abundant(n):
            abundant.append(n)
        n += 1
    return abundant

if len(sys.argv) != 2:
    raise ValueError("usage: script.py n")
N = int(sys.argv[1])
print(", ".join(map(str, abundant_numbers(N))))
