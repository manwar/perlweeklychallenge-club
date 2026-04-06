#!/usr/bin/env python3

# Perl Weekly Challenge 176 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-176/

def is_reversible(n):
    rev = int(str(n)[::-1])
    return (n + rev) % 2 == 1 and all(d in '13579' for d in str(n + rev))

def reversibles_up_to(N):
    result = []
    n = 1
    while n < N:
        if is_reversible(n):
            result.append(n)
        n += 1
    return result

import sys

if len(sys.argv) != 2:
    raise ValueError("usage: ch-2.py N")
N = int(sys.argv[1])
print("("+(", ".join(map(str, reversibles_up_to(N))))+")")
