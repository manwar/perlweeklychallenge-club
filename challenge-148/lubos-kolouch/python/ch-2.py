#!/usr/bin/env python
# -*- coding: utf-8 -*-

import cmath


def generate_cardano_triplets(n):
    triplets = []
    a = 1
    while len(triplets) < n:
        for b in range(0, a, 2):  # b is even
            for c in range(1, a, 2):  # c is odd
                val = (a + b * c**2) ** (1 / 3) + (a - b * c**2) ** (1 / 3)
                if abs(val.real - 1) < 1e-10 and abs(val.imag) < 1e-10:
                    triplets.append((a, b, c))
                    if len(triplets) == n:
                        return triplets
        a += 2  # a is odd
    return triplets


print(generate_cardano_triplets(5))
