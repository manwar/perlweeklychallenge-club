#!/usr/bin/env python3

# Challenge 147
#
# TASK #1 > Truncatable Prime
# Submitted by: Mohammad S Anwar
# Write a script to generate first 20 left-truncatable prime numbers in base 10.
#
# In number theory, a left-truncatable prime is a prime number which, in a given
# base, contains no 0, and if the leading left digit is successively removed,
# then all resulting numbers are primes.
#
# Example
# 9137 is one such left-truncatable prime since 9137, 137, 37 and 7 are all
# prime numbers.

from sympy import isprime, nextprime

def left_truncatable_prime_it():
    prime = None
    while True:
        prime = nextprime(prime) if prime is not None else 2
        if is_left_truncatable_prime(prime):
            yield prime

def is_left_truncatable_prime(p):
    while True:
        if not isprime(p):
            return False
        p = int(str(p)[1:]) if len(str(p)) > 1 else ''
        if p == '':
            return True

it = left_truncatable_prime_it()
out = [next(it) for _ in range(20)]
print(", ".join(map(str, out)))
