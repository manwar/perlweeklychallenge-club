#!/usr/bin/env perl

# Challenge 154
#
# TASK #2 > Padovan Prime
# Submitted by: Mohammad S Anwar
# A Padovan Prime is a Padovan Number that's also prime.
#
# In number theory, the Padovan sequence is the sequence of integers P(n)
# defined by the initial values.
#
# P(0) = P(1) = P(2) = 1
# and then followed by
#
# P(n) = P(n-2) + P(n-3)
# First few Padovan Numbers are as below:
#
# 1, 1, 1, 2, 2, 3, 4, 5, 7, 9, 12, 16, 21, 28, 37, ...
# Write a script to compute first 10 distinct Padovan Primes.
#
# Expected Output
# 2, 3, 5, 7, 37, 151, 3329, 23833, 13091204281, 3093215881333057

from functools import lru_cache
from sympy import isprime

@lru_cache(None)
def padovan(n):
    if n < 3:
        return 1
    else:
        return padovan(n - 2) + padovan(n - 3)

def padovan_iter():
    n = 0
    while True:
        n += 1
        yield padovan(n)

def padovan_prime_iter():
    padovan_it = padovan_iter()
    for got in padovan_it:
        if isprime(got):
            yield got

def uniq_padovan_prime_it():
    got = set()
    padovan_prime_it = padovan_prime_iter()
    while True:
        for value in padovan_prime_it:
            if value not in got:
                got.add(value)
                yield value

it = uniq_padovan_prime_it()
out = [next(it) for _ in range(10)]
print(", ".join(map(str, out)))
