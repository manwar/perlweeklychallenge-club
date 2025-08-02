#!/usr/bin/env python3

# Challenge 155
#
# TASK #1 > Fortunate Numbers
# Submitted by: Mohammad S Anwar
# Write a script to produce first 8 Fortunate Numbers (unique and sorted).
#
# According to Wikipedia
#
# A Fortunate number, named after Reo Fortune, is the smallest integer m > 1
# such that, for a given positive integer n, pn# + m is a prime number, where
# the primorial pn# is the product of the first n prime numbers.
#
# Expected Output
# 3, 5, 7, 13, 17, 19, 23, 37

from math import prod
from sympy import isprime, nextprime

fortunate = {}

primes = [2]
while len(fortunate) < 8:
    p = prod(primes)
    m = 2
    while not isprime(p + m):
        m += 1
    fortunate[m] = 1
    primes.append(nextprime(primes[-1]))

print(", ".join(map(str, sorted(fortunate.keys()))))
