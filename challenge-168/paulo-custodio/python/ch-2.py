#!/usr/bin/env python3

# Challenge 168
#
# Task 2: Home Prime
# Submitted by: Mohammad S Anwar
#
# You are given an integer greater than 1.
#
# Write a script to find the home prime of the given number.
#
# In number theory, the home prime HP(n) of an integer n greater than 1 is the
# prime number obtained by repeatedly factoring the increasing concatenation of
# prime factors including repetitions.
#
# Further information can be found on Wikipedia and OEIS.
# Example
#
# As given in the Wikipedia page,
#
# HP(10) = 773, as 10 factors as 2x5 yielding HP10(1) = 25, 25 factors as 5x5
# yielding HP10(2) = HP25(1) = 55, 55 = 5x11 implies HP10(3) = HP25(2) = HP55(1)
# = 511, and 511 = 7x73 gives HP10(4) = HP25(3) = HP55(2) = HP511(1) = 773, a
# prime number.

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
