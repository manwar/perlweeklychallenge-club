#!/usr/bin/env python3

# Perl Weekly Challenge 170 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-170/

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
print("("+(", ".join(map(str, primorial_numbers(n))))+")")
