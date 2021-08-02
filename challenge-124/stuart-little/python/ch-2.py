#!/usr/bin/env python

# run <script> <space-separated numbers>

from itertools import combinations
import sys

def splt(nums):
    return(min([(cmb,tuple(set(nums).difference(cmb))) for cmb in combinations(nums,len(nums)//2)], key=lambda tup: abs(sum(tup[0]) - sum(tup[1]))))

for ar in splt([int(x) for x in sys.argv[1:]]):
    print(ar)
