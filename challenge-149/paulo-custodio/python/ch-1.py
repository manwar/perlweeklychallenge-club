#!/usr/bin/env python3

# Challenge 149
#
# TASK #1 > Fibonacci Digit Sum
# Submitted by: Roger Bell_West
# Given an input $N, generate the first $N numbers for which the sum of their
# digits is a Fibonacci number.
#
# Example
# f(20)=[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]

import sys
from functools import reduce

def is_fibonacci(n):
    # Function to check if a number is a Fibonacci number
    a, b = 0, 1
    while a < n:
        a, b = b, a + b
    return a == n

def sum_of_digits_is_fibonacci(n):
    digits = [int(d) for d in str(n)]
    total = sum(digits)
    return is_fibonacci(total)

count = int(sys.argv[1])
out = []
n = 0
while len(out) < count:
    if sum_of_digits_is_fibonacci(n):
        out.append(n)
    n += 1

print(", ".join(map(str, out)))
