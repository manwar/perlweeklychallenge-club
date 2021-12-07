#!/usr/bin/env python3

# Challenge 125
#
# TASK #1 > Pythagorean Triples
# Submitted by: Cheok-Yin Fung
# You are given a positive integer $N.
#
# Write a script to print all Pythagorean Triples containing $N as a member.
# Print -1 if it can't be a member of any.
#
# Triples with the same set of elements are considered the same, i.e. if your
# script has already printed (3, 4, 5), (4, 3, 5) should not be printed.
#
# The famous Pythagorean theorem states that in a right angle triangle, the
# length of the two shorter sides and the length of the longest side are
# related by a2+b2 = c2.
#
# A Pythagorean triple refers to the triple of three integers whose lengths can
# compose a right-angled triangle.
#
# Example
#     Input: $N = 5
#     Output:
#         (3, 4, 5)
#         (5, 12, 13)
#
#     Input: $N = 13
#     Output:
#         (5, 12, 13)
#         (13, 84, 85)
#
#     Input: $N = 1
#     Output:
#         -1

import sys
from math import gcd

MAX_GEN = 100

def gen_pythagorean_triples():
    out = []
    seen = set()
    for m in range(2, MAX_GEN+1):
        for n in range(1, m):
            if gcd(m, n)==1:
                a = m*m-n*n
                b = 2*m*n
                c = m*m+n*n
                if m%2==1 and n%2==1:
                    a = a/2
                    b = b/2
                    c = c/2
                if a > b:
                    a, b = b, a
                if (a,b) not in seen:
                    seen.add((a,b))
                    out.append([a, b, c])
    return out

N = int(sys.argv[1])
pythagorean_triples = gen_pythagorean_triples()
found = filter(lambda x : x[0]==N or x[1]==N or x[2]==N, pythagorean_triples)
printed = False
for triplet in found:
    print("("+ ", ".join([str(x) for x in triplet]) +")")
    printed = True
if not printed:
    print(-1)
