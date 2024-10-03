#!/usr/bin/env python3

# Challenge 168
#
# Task 1: Perrin Prime
# Submitted by: Roger Bell_West
#
# The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is
# the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ....)
#
#     A Perrin prime is a number in the Perrin sequence which is also a prime
#     number.
#
# Calculate the first 13 Perrin Primes.
#
# f(13) = [2, 3, 5, 7, 17, 29, 277, 367, 853, 14197, 43721, 1442968193,
#          792606555396977]

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

def perrin_seq():
    t = [3, 0, 2]
    def next_perrin():
        t.append(t[-2] + t[-3])
        return t.pop(0)
    return next_perrin

def perrin_prime_seq():
    it = perrin_seq()
    seen = {}
    def next_perrin_prime():
        while True:
            n = it()
            if is_prime(n) and n not in seen:
                seen[n] = True
                return n
    return next_perrin_prime

import sys

if len(sys.argv) != 2:
    raise ValueError("usage: ch-1.py n")
n = int(sys.argv[1])
pp = []
it = perrin_prime_seq()
while len(pp) < n:
    pp.append(it())
print(", ".join(map(str, sorted(pp))))
