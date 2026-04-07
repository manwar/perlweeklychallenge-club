#!/usr/bin/env python3

# Perl Weekly Challenge 169 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-169/

import sys

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

def is_brillant(n):
    factors = prime_factors(n)
    return len(factors) == 2 and is_prime(factors[0]) and is_prime(factors[1]) and len(str(factors[0])) == len(str(factors[1]))

def brillant_seq():
    n = 1
    while True:
        n += 1
        if is_brillant(n):
            yield n

if len(sys.argv) != 2:
    raise ValueError("usage: ch-1.py n")
n = int(sys.argv[1])
brillant = []
it = brillant_seq()
while len(brillant) < n:
    brillant.append(next(it))
print("("+(", ".join(map(str, brillant)))+")")
