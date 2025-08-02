#!/usr/bin/env python3

# Challenge 172
#
# Task 1: Prime Partition
# Submitted by: Mohammad S Anwar
#
# You are given two positive integers, $m and $n.
#
# Write a script to find out the Prime Partition of the given number. No
# duplicates allowed.
#
# For example,
#
# Input: $m = 18, $n = 2
# Output: 5, 13 or 7, 11
#
# Input: $m = 19, $n = 3
# Output: 3, 5, 11

import sys
from itertools import count
from functools import reduce

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

def next_prime(n):
    if n <= 1:
        return 2
    p = n
    while True:
        p += 1
        if is_prime(p):
            return p

def primes(n):
    p = 2
    prime_list = []
    while p <= n:
        prime_list.append(p)
        p = next_prime(p)
    return prime_list

def odometer_increment(limit, n):
    i = len(n) - 1
    while True:
        n[i] += 1
        if n[i] >= limit:
            n[i] = 0
            i -= 1
            if i < 0:
                n.insert(0, 0)
                i = 0
        else:
            break
    return n

def has_duplicates(n):
    seen = set()
    for num in n:
        if num in seen:
            return True
        seen.add(num)
    return False

def prime_partition(m, n):
    prime_list = primes(m)
    idx = [0] * n
    while len(idx) == n:
        if not has_duplicates(idx):
            terms = [prime_list[i] for i in idx]
            if sum(terms) == m:
                return terms
        idx = odometer_increment(len(prime_list), idx)
    return []

if len(sys.argv) != 3:
    raise ValueError("usage: ch-1.py m n")
m, n = map(int, sys.argv[1:])
print(", ".join(map(str, prime_partition(m, n))))
