#!/usr/bin/env python3

# TASK #2 > Distinct Terms Count
# Submitted by: Mohammad S Anwar
# You are given 2 positive numbers, $m and $n.
# 
# Write a script to generate multiplication table and display count of distinct 
# terms.

import sys

m, n = int(sys.argv[1]), int(sys.argv[2])
terms = set()
for a in range(1, m+1):
    for b in range(1, n+1):
        prod = a * b
        terms.add(prod)
print(len(terms))
