#!/usr/bin/python3

# Challenge 144
#
# TASK #2 > Ulam Sequence
# Submitted by: Mohammad S Anwar
# You are given two positive numbers, $u and $v.
#
# Write a script to generate Ulam Sequence having at least 10 Ulam numbers
# where $u and $v are the first 2 Ulam numbers.
#
# For more information about Ulam Sequence, please checkout the website.
#
# The standard Ulam sequence (the (1, 2)-Ulam sequence) starts with U1 = 1 and
# U2 = 2. Then for n > 2, Un is defined to be the smallest integer that is the
# sum of two distinct earlier terms in exactly one way and larger than all
# earlier terms.

import sys
from itertools import combinations

NUM_TERMS = 10

def ulam_seq(u, v):
    def next_ulam(terms):
        # get all combinations of 2 items from previous terms
        # compute sum for all combinations
        sums = {}
        for items in combinations(terms, 2):
            n = sum(items)
            if n not in sums:
                sums[n] = []
            sums[n].append(items)

        # choose smallest sum that has only one possible combination and
        # is larger than previous ones
        for n in sorted(sums):
            if n > terms[-1]:
                if len(sums[n])==1:
                    return n
        print("no solution found for ", *terms)
        sys.exit(1)

    terms = []

    # first two terms
    terms.append(u)
    yield u

    terms.append(v)
    yield v

    # other terms
    while True:
        n = next_ulam(terms)
        terms.append(n)
        yield n

u = int(sys.argv[1])
v = int(sys.argv[2])
seq = []
for n in ulam_seq(u, v):
    seq.append(n)
    if len(seq) >= NUM_TERMS:
        break
print(*seq, sep=", ")
