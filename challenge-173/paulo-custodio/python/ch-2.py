#!/usr/bin/env python3

# Perl Weekly Challenge 173 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-173/

import sys

def sylvester_seq(N):
    n = [2]
    prod = 2
    while len(n) < N:
        term = prod + 1
        n.append(term)
        prod *= term
    return n

if len(sys.argv) != 2:
    raise ValueError("usage: ch-2.py n")
print("("+(", ".join(map(str, sylvester_seq(int(sys.argv[1])))))+")")
