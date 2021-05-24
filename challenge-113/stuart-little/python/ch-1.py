#!/usr/bin/env python

# run <script> <number> <digit>

import sys

def lastDigSumm(nr, dig, nrSummands):
    return ((nr - nrSummands * dig) % 10 == 0) and (nrSummands * dig <= nr) and (nrSummands * ((dig -1) * 10 + dig) >= nr)

def lastDig(nr,dig):
    return bool(list(filter(lambda x: lastDigSumm(nr,dig,x), range(1,10))))

def sol(nr,dig):
    if (dig == 0):
        return (nr >= 101 or (nr % 10 == 0))
    return ((nr >= dig * 11) or lastDig(nr,dig));

print(int(sol(*map(int,sys.argv[1:]))))
