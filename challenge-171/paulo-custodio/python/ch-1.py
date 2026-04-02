#!/usr/bin/env python3

# Perl Weekly Challenge 171 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-171/

import sys
import math
from functools import reduce

def divisors(n):
    div_low = []
    div_high = []
    for i in range(1, int(math.sqrt(n)) + 1):
        if n % i == 0:
            div_low.append(i)
            if n // i != i:
                div_high.insert(0, n // i)
    return div_low + div_high

def proper_divisors(n):
    div = divisors(n)
    return div[:-1]

def is_abundant(n):
    return sum(proper_divisors(n)) > n

def abundant_numbers(N):
    abundant = []
    n = 1
    while len(abundant) < N:
        if is_abundant(n):
            abundant.append(n)
        n += 1
    return abundant

if len(sys.argv) != 2:
    raise ValueError("usage: script.py n")
N = int(sys.argv[1])
print("("+(", ".join(map(str, abundant_numbers(N))))+")")
