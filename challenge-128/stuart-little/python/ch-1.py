#!/usr/bin/env python

# run <script> <space-separated binary words, with one word representing each row>

from functools import reduce
import re
import sys

rows,cols=0,0

def mrg(s1,s2):
    return f"{int(bin(int(s1,2) | int(s2,2))[2:]):0{len(s1)}d}"

for (i,j) in [(i,j) for i in range(len(sys.argv[1:])) for j in range(i,len(sys.argv[1:]))]:
    mx=max(re.split(r"[^0]+",reduce(mrg,sys.argv[1+i:2+j])), key=len)
    if (j-i+1)*len(mx) > rows*cols:
        rows,cols=j-i+1,len(mx)

print("\n".join(['0' * cols] * rows))
