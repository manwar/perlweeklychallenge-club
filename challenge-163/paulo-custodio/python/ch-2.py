#!/usr/bin/env python3

# Perl Weekly Challenge 163 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-163/

import sys
from functools import reduce

def summation(*n):
    n = list(n)
    while len(n) > 1:
        n.pop(0)
        m = []
        for i in range(len(n)):
            m.append(sum(n[:i + 1]))
        n = m
    return n[0]

print(summation(*map(int, sys.argv[1:])))
