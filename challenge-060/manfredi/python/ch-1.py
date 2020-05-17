#!/usr/bin/env python3
import re
import sys
from braceexpand import braceexpand


if len(sys.argv) != 2:
    print("USAGE:\n\t %s { ABC | 123 }" % __file__)
    sys.exit()


cols = []
a = list(braceexpand('{A..Z}'))
b = list(braceexpand('{A..Z}{A..Z}'))
c = list(braceexpand('{A..Z}{A..Z}{A..Z}'))

cols.extend(a)
cols.extend(b)
cols.extend(c)

nums = [ n for n in range(1, len(cols) + 1) ]

hcols = dict()
hnums = dict()

for i in range(len(cols)):
    hcols[ str(cols[i]) ] = nums[i]
    hnums[ str(nums[i]) ] = cols[i]


pattern_nums = re.compile(r'^\d+$')
pattern_cols = re.compile(r'^[A-Z]{1,3}$')

if pattern_nums.match(sys.argv[1]) and int(sys.argv[1]) <= len(nums):
    print( hnums[ sys.argv[1] ] )

if pattern_cols.match(sys.argv[1]):
    print( hcols[ sys.argv[1] ] )

