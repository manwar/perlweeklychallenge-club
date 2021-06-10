#!/usr/bin/env python

# run <script> <number>

import sys

nrDig = len(sys.argv[1])

if (sys.argv[1] == '9' * nrDig):
    print(int(sys.argv[1])+2)
    sys.exit()

def doubleUp(nrDig, initHalf):
    return initHalf + (initHalf[:-1][::-1] if (nrDig % 2) else initHalf[::-1])

initHalf = sys.argv[1][0:int((nrDig+1)/2)]

print((doubleUp(nrDig,initHalf)) if (int(doubleUp(nrDig,initHalf)) > int(sys.argv[1])) else (doubleUp(nrDig,(str(int(initHalf)+1)))) )
