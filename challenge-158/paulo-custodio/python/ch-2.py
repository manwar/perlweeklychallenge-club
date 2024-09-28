#!/usr/bin/env python3

# Challenge 158
#
# TASK #2 > First Series Cuban Primes
# Submitted by: Mohammad S Anwar
# Write a script to compute first series Cuban Primes <= 1000. Please refer
# wikipedia page for more informations.
#
# Output
# 7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919.
#
#     p=(x^3-y^3)/(x-y), x=y+1, y>0
# <=> p=3y^2+3y+1, y>0

from sympy import isprime

def cuban_primes(limit):
    out = []
    y = 1
    p = 0
    while True:
        p = 3 * y * y + 3 * y + 1
        if isprime(p):
            out.append(p)
        if p >= limit:
            break
        y += 1
    return out

print(", ".join(map(str, cuban_primes(1000))))
