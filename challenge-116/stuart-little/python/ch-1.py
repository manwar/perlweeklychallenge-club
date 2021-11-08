#!/usr/bin/env python

# run <script> <number>

import sys

def fstRunOver(s1,s2):
    return next(filter(lambda xs: len(s2) <= sum([len(str(x)) for x in xs]), [[int(s1) + i for i in range(j)] for j in range(1,len(s2)+1)]))

def consecSplit(s):
    return next(filter(lambda xs: s == ''.join(map(str,xs)), map(lambda x: fstRunOver(x,s), map(lambda i: s[:i+1], range(len(s))))))

print(consecSplit(sys.argv[1]))
