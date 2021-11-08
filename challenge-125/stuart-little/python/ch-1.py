#!/usr/bin/env python

# run <script> <number>

import math
import sys

def trps(n):
    triples=[]
    triples.extend([[x, math.floor(math.sqrt(n**2-x**2)), n] for x in range(1,math.ceil((n+1)/2)+1) if x<n and x**2 + math.floor(math.sqrt(n**2-x**2))**2 == n**2 ])
    triples.extend([ [math.floor((math.floor(n**2/x)-x)/2),n,math.floor((math.floor(n**2/x)+x)/2)] for x in [i for i in range(1,n) if n**2 % i == 0 and i%2==(math.floor(n**2/i))%2]])
    return triples

sol = trps(int(sys.argv[1]))
if len(sol)>0:
    [print(i) for i in sol]
    sys.exit()
print(-1)
