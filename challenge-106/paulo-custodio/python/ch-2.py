#!/usr/bin/env python3

# Challenge 106
#
# TASK #2 > Decimal String
# Submitted by: Mohammad S Anwar
# You are given numerator and denominator i.e. $N and $D.
#
# Write a script to convert the fraction into decimal string. If the fractional
# part is recurring then put it in parenthesis.
#
# Example
# Input: $N = 1, $D = 3
# Output: "0.(3)"
#
# Input: $N = 1, $D = 2
# Output: "0.5"
#
# Input: $N = 5, $D = 66
# Output: "0.0(75)"

import sys
import re
from decimal import *

def frac2str(n, d):
    getcontext().prec = 1000
    getcontext().rounding = ROUND_DOWN

    n = Decimal(n)
    d = Decimal(d)
    q = str(n/d)

    for rept in range(1,101):
        match = re.search(r"((\d{"+str(rept)+r"})\2+\d*)", q)
        if match:
            q = re.sub(match.group(1), "("+match.group(2)+")", q)
            return q
    return q

print(frac2str(int(sys.argv[1]), int(sys.argv[2])))
