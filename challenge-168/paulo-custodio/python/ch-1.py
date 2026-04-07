#!/usr/bin/env python3

# Perl Weekly Challenge 168 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-168/

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
print("("+(", ".join(map(str, sorted(pp))))+")")
