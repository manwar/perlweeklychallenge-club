#!/usr/bin/env python
# -----------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-07-31
# Challenge 228 Task 1 Unique Sum ( Python )
# -----------------------------------------

myints = [[2, 1, 3, 2],[1, 1, 1, 1],[2, 1, 3, 4]]

hash = dict()

def CreateHash(h):
    ln = len(h)
    cnt = 0
    while cnt < ln:
        hkey = h[cnt]
        hash[hkey] = 0
        cnt += 1

    cnt = 0

    while cnt < ln:
        hkey = h[cnt]
        hash[hkey] += 1
        cnt += 1


def FindUniqueSum():
    flag = 0
    sum = 0
    for (key) in hash:
        if hash[key] == 1:
            sum += key
    print("Output: ",sum,"\n")

for h in myints:
    print("Input: @int = ", h)
    CreateHash(h)
    FindUniqueSum()
    hash = dict()


# -----------------------------------------
# SAMPLE OUTPUT
# python .\UniqueSum.py

# Input: @int =  [2, 1, 3, 2]
# Output:  4

# Input: @int =  [1, 1, 1, 1]
# Output:  0

# Input: @int =  [2, 1, 3, 4]
# Output:  10
# -----------------------------------------



