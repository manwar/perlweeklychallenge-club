#!/usr/bin/env python3

# Challenge 177
#
# Task 2: Palindromic Prime Cyclops
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Palindromic Prime Cyclops Numbers.
#
#     A cyclops number is a number with an odd number of digits that has a zero
#     in the center only.
#
#
# Output
#
# 101, 16061, 31013, 35053, 38083, 73037, 74047, 91019, 94049,
# 1120211, 1150511, 1160611, 1180811, 1190911, 1250521, 1280821,
# 1360631, 1390931, 1490941, 1520251

import re
import sys

def is_palindromic(n):
    return str(n) == str(n)[::-1]

def is_cyclops(n):
    if found := re.match(r'^([1-9]+)0([1-9]+)$', str(n)):
        return len(found.group(1)) == len(found.group(2))
    else:
        return False

def is_prime(n):
    if n <= 1:
        return False
    if n <= 3:
        return True
    if n % 2 == 0 or n % 3 == 0:
        return False
    for i in range(5, int(n**0.5) + 1, 6):
        if n % i == 0 or n % (i + 2) == 0:
            return False
    return True

def is_palindromic_cyclops_prime(n):
    return is_palindromic(n) and is_cyclops(n) and is_prime(n)

def palindromic_cyclops_prime(N):
    n = 100
    result = []
    while len(result) < N:
        if is_palindromic_cyclops_prime(n):
            result.append(n)
        n += 1
    return result

N = int(sys.argv[1])
print(", ".join(map(str, palindromic_cyclops_prime(N))))
