#!/usr/bin/env python3

# Challenge 158
#
# TASK #1 > Additive Primes
# Submitted by: Mohammad S Anwar
# Write a script to find out all Additive Primes <= 100.
#
# Additive primes are prime numbers for which the sum of their decimal digits
# are also primes.
#
#
# Output
# 2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89

from sympy import isprime, nextprime

def additive_primes(limit):
    out = []
    prime = 2
    while prime < limit:
        if isprime(sum(int(digit) for digit in str(prime))):
            out.append(prime)
        prime = nextprime(prime)
    return out

print(", ".join(map(str, additive_primes(100))))
