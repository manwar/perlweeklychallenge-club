#!/usr/bin/env python3

# Challenge 175
#
# Task 2: Perfect Totient Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Perfect Totient Numbers. Please checkout
# wikipedia page for more informations.
#
# Output
#
# 3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
# 2187, 2199, 3063, 4359, 4375, 5571

import sys

def gcd(a, b):
    if a == 0:
        return b
    else:
        return gcd(b % a, a)

def totient(n):
    count = 0
    for i in range(1, n + 1):
        if gcd(n, i) == 1:
            count += 1
    return count

def is_perfect_totient(n):
    total = n
    sum_totients = 0
    while total != 1:
        total = totient(total)
        sum_totients += total
    return sum_totients == n

def perfect_totients(N):
    result = []
    n = 1
    while len(result) < N:
        if is_perfect_totient(n):
            result.append(n)
        n += 1
    return result

if len(sys.argv) != 2:
    raise ValueError("usage: ch-2.py N")
N = int(sys.argv[1])
print(", ".join(map(str, perfect_totients(N))))
