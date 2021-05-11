#!/usr/bin/env python

# run <script> <number>

import sys

memo = [
    [[1,],],
    [[1,1],[2,]],
]

def memoSteps(n):
    if (n > len(memo)-1):
        memo.append([*(map(lambda a: [1,*a], memoSteps(n-1))),*(map(lambda a: [2,*a], memoSteps(n-2)))])
    return memo[n]

res = memoSteps(int(sys.argv[1])-1)
print(f"""{len(res)}
{'-' * 12}""")
for ar in res:
    print(ar)
