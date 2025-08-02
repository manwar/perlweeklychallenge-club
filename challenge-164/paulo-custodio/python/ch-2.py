#!/usr/bin/env python3

# Challenge 164
#
# Task 2: Happy Numbers
# Submitted by: Robert DiCicco
#
# Write a script to find the first 8 Happy Numbers in base 10. For more
# information, please check out Wikipedia.
#
# Starting with any positive integer, replace the number by the sum of the
# squares of its digits, and repeat the process until the number equals 1 (where
# it will stay), or it loops endlessly in a cycle which does not include 1.
#
# Those numbers for which this process end in 1 are happy numbers, while those
# numbers that do not end in 1 are unhappy numbers.
# Example
#
# 19 is Happy Number in base 10, as shown:
#
# 19 => 1^2 + 9^2
#    => 1   + 81
#    => 82 => 8^2 + 2^2
#          => 64  + 4
#          => 68 => 6^2 + 8^2
#                => 36  + 64
#                => 100 => 1^2 + 0^2 + 0^2
#                       => 1 + 0 + 0
#                       => 1

import sys
from typing import List

def is_happy(n: int) -> bool:
    seen = set()
    while n != 1:
        if n in seen:
            return False
        seen.add(n)
        n = sum(int(digit) ** 2 for digit in str(n))
    return True

def happy_numbers(n: int) -> List[int]:
    happy = []
    i = 1
    while len(happy) < n:
        if is_happy(i):
            happy.append(i)
        i += 1
    return happy

print(", ".join(map(str, happy_numbers(int(sys.argv[1])))))
