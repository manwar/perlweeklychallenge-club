#!/usr/bin/env python3

# Perl Weekly Challenge 164 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-164/

import sys
from typing import List

def is_happy(n: int) -> bool:
    seen = set()
    while n != 1:
        if n in seen:
            return False
        seen.add(n)
        n = sum(int(digit) ** 2 for digit in str(n))
    return True

def happy_numbers(n: int) -> List[int]:
    happy = []
    i = 1
    while len(happy) < n:
        if is_happy(i):
            happy.append(i)
        i += 1
    return happy

print("("+(", ".join(map(str, happy_numbers(int(sys.argv[1])))))+")")
