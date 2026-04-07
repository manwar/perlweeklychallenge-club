#!/usr/bin/env python3

# Perl Weekly Challenge 168 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-168/

def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    i = 5
    while i * i <= n:
        if n % i == 0 or n % (i + 2) == 0:
            return False
        i += 6
    return True

def prime_factors(n):
    factors = []
    p = 0
    while n > 1:
        p += 1
        while not is_prime(p):
            p += 1
        while n % p == 0:
            factors.append(p)
            n //= p
    return factors

def home_prime(n):
    if n <= 1:
        raise ValueError("Input must be greater than 1")
    while not is_prime(n):
        factors = prime_factors(n)
        n = int(''.join(map(str, factors)))
    return n

import sys

if len(sys.argv) != 2:
    raise ValueError("usage: script.py n")
print(home_prime(int(sys.argv[1])))
