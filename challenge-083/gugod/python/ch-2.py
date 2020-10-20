#!/usr/bin/env python3
import sys
import itertools

def flipCombination(A):
    minSum = nSum = sum(A)
    minCombination = ()
    for k in range(1, len(A)):
        for c in itertools.combinations(A, k):
            s = nSum - 2 * sum(c)
            if 0 <= s < minSum:
                minCombination = c
                minSum = s
                yield minSum, minCombination


def flipElems(A):
    minSum = 0
    minCombination = ()
    for minSum, minCombination in flipCombination(A):
        if minSum == 0:
            break
    print(f'>> {minSum} = sum({A}) - 2 * sum({minCombination})')
    return len(minCombination)

# print(flipElems([2,13,10,8]))   # 2
# print(flipElems([10,12,2]))   # 1
print(flipElems(list(map(int, sys.argv[1:]))))
