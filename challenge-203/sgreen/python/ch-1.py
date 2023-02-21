#!/usr/bin/env python3

from itertools import combinations
import sys

def main(n):
    solutions = 0

    # Work through all combinations of positions
    for x in combinations(range(len(n)), 4):
        i, j, k, l = sorted(x)
        if n[i] + n[j] + n[k] == n[l]:
            solutions += 1

    # No solution is found
    print(solutions)

if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
