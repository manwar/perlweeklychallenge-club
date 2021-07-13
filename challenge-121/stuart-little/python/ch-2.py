#!/usr/bin/env python

# run <script> <nr of cities>

from itertools import permutations
import random
import sys

def mkRMat(n):
    return [[0 if j==i else random.randint(1,9) for j in range(1,n+1)] for i in range(1,n+1)]

def sayMat(m):
    for i in m: print(i)

def pathCost(path,mat):
    return sum([mat[path[i]][path[(i+1)% len(path)]] for i in range(len(path))])

nr=int(sys.argv[1])
mat = mkRMat(nr)

print("Your matrix:")
sayMat(mat)

sol = min([(perm,pathCost(perm,mat)) for perm in permutations(range(nr))], key=lambda p: p[1])

print(f"Optimal cost: {sol[1]}")
print(f"Optimal path: {list(sol[0]) + [sol[0][0]]}")
