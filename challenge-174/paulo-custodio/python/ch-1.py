#!/usr/bin/env python3

# Perl Weekly Challenge 174 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-174/

import sys
from typing import List

def is_disarium(n: int) -> bool:
    digits = [int(d) for d in str(n)]
    return sum(d ** (i + 1) for i, d in enumerate(digits)) == n

def disarium_numbers(N: int) -> List[int]:
    result = []
    n = 1
    while len(result) < N:
        if is_disarium(n):
            result.append(n)
        n += 1
    return result

if len(sys.argv) != 2:
    raise ValueError("usage: script.py n")
print("("+(", ".join(map(str, disarium_numbers(int(sys.argv[1])))))+")")
