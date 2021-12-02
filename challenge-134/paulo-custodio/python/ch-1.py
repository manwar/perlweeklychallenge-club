#!/usr/bin/env python3

# Challenge 134
#
# TASK #1 > Pandigital Numbers
# Submitted by: Mohammad S Anwar
# Write a script to generate first 5 Pandigital Numbers in base 10.
#
# As per the wikipedia, it says:
#
# A pandigital number is an integer that in a given base has among its
# significant digits each digit used in the base at least once.

# solution from https://oeis.org/A050278

from itertools import permutations

A050278 = [int(''.join(d)) for d in permutations('0123456789', 10) if d[0] != '0']
A050278.sort()
for i in range(0, 5):
    print(A050278[i])
