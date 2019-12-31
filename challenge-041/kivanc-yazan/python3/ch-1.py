#!/usr/bin/env python3
from sympy import isprime, factorint

# Problem: Write a script to display attractive number between 1 and 50.

for i in range(1,51):
    factors = factorint(i)
    factor_count = sum(factors.values())
    if isprime(factor_count):
        print(i,' ',factors)
