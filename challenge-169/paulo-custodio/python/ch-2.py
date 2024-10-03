#!/usr/bin/env python3

# Challenge 169
#
# Task 2: Achilles Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Achilles Numbers. Please checkout wikipedia
# for more information.
#
#     An Achilles number is a number that is powerful but imperfect (not a
#     perfect power). Named after Achilles, a hero of the Trojan war, who was
#     also powerful but imperfect.
#
#     A positive integer n is a powerful number if, for every prime factor p of
#     n, p^2 is also a divisor.
#
#     A number is a perfect power if it has any integer roots (square root, cube
#     root, etc.).
#
# For example 36 factors to (2, 2, 3, 3) - every prime factor (2, 3) also has its
# square as a divisor (4, 9). But 36 has an integer square root, 6, so the number
# is a perfect power.
#
# But 72 factors to (2, 2, 2, 3, 3); it similarly has 4 and 9 as divisors, but it
# has no integer roots. This is an Achilles number.
#
# Output
#
#  72, 108,  200,  288,  392,  432,  500,  648,  675,  800,  864, 968, 972, 1125,
#  1152, 1323, 1352, 1372, 1568, 1800

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

def is_powerfull(n):
    factors = prime_factors(n)
    for factor in factors:
        if n % (factor * factor) != 0:
            return False
    return True

def is_perfect(n):
    for e in range(2, n + 1):
        for b in range(1, n + 1):
            power = b ** e
            if power == n:
                return True
            if power > n:
                break
    return False

def is_aquilles(n):
    return is_powerfull(n) and not is_perfect(n)

def aquilles_seq():
    n = 1
    while True:
        n += 1
        if is_aquilles(n):
            yield n

import sys

if len(sys.argv) != 2:
    raise ValueError("usage: ch-2.py n")
n = int(sys.argv[1])
aquilles = []
it = aquilles_seq()
while len(aquilles) < n:
    aquilles.append(next(it))
print(", ".join(map(str, aquilles)))
