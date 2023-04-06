#!/usr/bin/env python
# -*- coding: utf-8 -*-

from itertools import permutations

# Initialize the ring numbers and available numbers
rings = {"Blue": 8, "Black": None, "Red": 9, "Yellow": 7, "Green": 5}
available = [1, 2, 3, 4, 6]

# Generate all possible permutations of the available numbers
for b, k, r, y, g in permutations(available):
    # Skip if any number is repeated
    if b == k or b == r or b == y or b == g:
        continue
    if k == r or k == y or k == g:
        continue
    if r == y or r == g:
        continue
    if y == g:
        continue
    # Check if the sum of numbers in each ring is 11
    if b + k + r == 11 and r + y + g == 11:
        # Save the solution
        rings["Blue"] = b
        rings["Black"] = k
        rings["Red"] = r
        rings["Yellow"] = y
        rings["Green"] = g
        print(rings)
