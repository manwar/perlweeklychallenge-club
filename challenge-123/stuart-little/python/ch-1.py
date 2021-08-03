#!/usr/bin/env python

# run <script> <number $n> to return the first $n ugly numbers

import sys

memo = set([1,2,3,5])
def smth5p(n):
    if n in memo:
        return True
    for prm in [2,3,5]:
        if (n % prm == 0) and int(n/prm) in memo:
            memo.add(n)
            return True
    return False
count,nr=0,0
while count < int(sys.argv[1]):
    nr+=1
    if smth5p(nr):
        print(nr)
        count+=1
