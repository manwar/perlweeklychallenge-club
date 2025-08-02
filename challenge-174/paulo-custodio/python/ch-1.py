#!/usr/bin/env python3

# Challenge 174
#
# Task 1: Disarium Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 19 Disarium Numbers.
#
#     A disarium number is an integer where the sum of each digit raised to the
#     power of its position in the number, is equal to the number.
#
#
# For example,
#
# 518 is a disarium number as (5 ** 1) + (1 ** 2) + (8 ** 3) => 5 + 1 + 512 => 518

import sys
from typing import List

def is_disarium(n: int) -> bool:
    digits = [int(d) for d in str(n)]
    return sum(d ** (i + 1) for i, d in enumerate(digits)) == n

def disarium_numbers(N: int) -> List[int]:
    result = []
    n = 1
    while len(result) < N:
        if is_disarium(n):
            result.append(n)
        n += 1
    return result

if len(sys.argv) != 2:
    raise ValueError("usage: script.py n")
print(", ".join(map(str, disarium_numbers(int(sys.argv[1])))))
