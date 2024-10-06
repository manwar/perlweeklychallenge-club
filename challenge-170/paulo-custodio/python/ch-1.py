#!/usr/bin/env python3

# Challenge 170
#
# Task 1: Primorial Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 10 Primorial Numbers.
#
#     Primorial numbers are those formed by multiplying successive prime numbers.
#
#
# For example,
#
# P(0) = 1    (1)
# P(1) = 2    (1x2)
# P(2) = 6    (1x2x3)
# P(3) = 30   (1x2x3x5)
# P(4) = 210  (1x2x3x5x7)

import sys

def is_prime(n):
    if n == 2 or n == 3:
        return True
    if n <= 1 or n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def next_prime(p):
    p += 1
    while not is_prime(p):
        p += 1
    return p

def primorial_numbers(n):
    primorial = [1]
    p = 1
    while len(primorial) < n:
        p = next_prime(p)
        primorial.append(primorial[-1] * p)
    return primorial

if len(sys.argv) != 2:
    raise ValueError("usage: ch-1.py n")
n = int(sys.argv[1])
print(", ".join(map(str, primorial_numbers(n))))
