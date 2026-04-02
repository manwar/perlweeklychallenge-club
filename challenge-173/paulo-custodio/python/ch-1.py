#!/usr/bin/env python3

# Perl Weekly Challenge 173 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-173/

def is_esthetic(n):
    n = list(map(int, str(n)))
    while len(n) > 1:
        if abs(n[0] - n[1]) != 1:
            return 0
        n.pop(0)
    return 1

import sys

if len(sys.argv) != 2:
    raise ValueError("usage: ch-1.py n")
print(1 if is_esthetic(sys.argv[1]) else 0)
