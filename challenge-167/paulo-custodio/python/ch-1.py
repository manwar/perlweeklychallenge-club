#!/usr/bin/env python3

# Challenge 167
#
# Task 1: Circular Prime
# Submitted by: Mohammad S Anwar
#
# Write a script to find out first 10 circular primes having at least 3 digits
# (base 10).
#
# Please checkout wikipedia for more information.
#
#     A circular prime is a prime number with the property that the number
#     generated at each intermediate step when cyclically permuting its (base 10)
#     digits will also be prime.
#
# Output
#
# 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933

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

def next_prime(n):
    if n <= 1:
        return 2
    p = n
    while not is_prime(p := p + 1):
        pass
    return p

seen = {}
def is_circular_prime(n):
    global seen

    if n in seen:
        return False
    seen[n] = True
    if n < 10:
        return False
    if any(digit in '024568' for digit in str(n)):
        return False
    rotations = []
    for _ in range(len(str(n))):
        rotations.append(n)
        if not is_prime(n):
            return False
        n = int(str(n)[1:] + str(n)[0])
    for rotation in rotations:
        seen[rotation] = True
    return True

def next_circular_prime(n):
    n += 1
    while not is_circular_prime(n):
        n = next_prime(n)
    return n

import sys

if len(sys.argv) != 2:
    raise ValueError("usage: ch-1.py n")
n = int(sys.argv[1])
cprimes = []
cp = 1
while len(cprimes) < n:
    cp = next_circular_prime(cp)
    if cp >= 100:
        cprimes.append(cp)
print(", ".join(map(str, cprimes)))
