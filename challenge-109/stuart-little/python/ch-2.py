#!/usr/bin/env python

# run <script> <space-separated numbers>

from itertools import permutations
import string
import sys

def sumsEqNr(nr,ar,bl):
    if (len(ar) <= 3):
        return bl and (nr == sum(ar))
    return sumsEqNr(nr,ar[2:],(bl and (nr == sum(ar[:3]))))

def allSumsEq(ar):
    return sumsEqNr(sum(ar[:2]),ar[1:],True)

def pprnt(ar):
    return "\nSolution: " + ", ".join([f"{c} = {v}" for (c,v) in list(zip(string.ascii_lowercase[:7],ar))]) + f"\nSum: {sum(ar[:2])}"

sols = list(filter(allSumsEq,list(permutations(map(int, sys.argv[1:])))))
print("No solution." if (not sols) else "\n".join(map(pprnt,sols)))
