#!/usr/bin/env python3

# Challenge 109
#
# TASK #1 - Chowla Numbers
# Submitted by: Mohammad S Anwar
# Write a script to generate first 20 Chowla Numbers, named after,
# Sarvadaman D. S. Chowla, a London born Indian American mathematician.
# It is defined as:
#
# C(n) = sum of divisors of n except 1 and n
# NOTE: Updated the above definition as suggested by Abigail [2021/04/19 18:40].
# Output:
# 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21

import sys
import math

def divisors(n):
    div_low = []
    div_high = []
    for i in range(1, int(math.sqrt(n)+1)):
        if n%i==0:
            div_low.append(i)
            if n/i!=i:
                div_high.append(int(n/i))
    div_high = div_high[::-1]
    return [*div_low, *div_high]

def chowla(n):
    terms = filter(lambda x: x!=1 and x!=n, divisors(n))
    return sum(terms)

def first_chowla(num):
    nums = []
    for i in range(1, num+1):
        nums.append(chowla(i))
    return nums

print(", ".join([str(x) for x in first_chowla(int(sys.argv[1]))]))
