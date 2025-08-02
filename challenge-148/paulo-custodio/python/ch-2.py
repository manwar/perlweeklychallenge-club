#!/usr/bin/env python3

# Challenge 148
#
# TASK #2 > Cardano Triplets
# Submitted by: Mohammad S Anwar
# Write a script to generate first 5 Cardano Triplets.
#
# A triplet of positive integers (a,b,c) is called a Cardano Triplet if it
# satisfies the below condition.
#
# Cardano Triplets
#
# Example
# (2,1,5) is the first Cardano Triplets.

from math import isqrt
from itertools import chain

def cardano_triplets(num):
    triplets = []
    K = 0
    while len(triplets) < num * 2:  # we are not sure in which order they are generated
        A = 2 + 3 * K
        T = (K + 1) ** 2 * (8 * K + 5)
        divs = divisors(T)
        for div in divs:
            if isqrt(div) ** 2 == div:
                B = isqrt(div)
                C = T // (B ** 2)
                triplets.append((A, B, C))
        triplets.sort(key=lambda x: sum(x))
        K += 1

    return triplets[:num]

def divisors(n):
    divs1 = []
    divs2 = []
    for k in range(1, n + 1):
        if divs2 and k >= divs2[0]:
            break
        if n % k == 0:
            divs1.append(k)
            divs2.insert(0, n // k)
    return list(chain(divs1, divs2))

triplets = cardano_triplets(5)
for triplet in triplets:
    print(f"({','.join(map(str, triplet))})")
