#!/usr/bin/env python3

from itertools import combinations
import sys

def main(n):
    # Work through all combinations of positions
    for x in combinations(range(len(n)), 3):
        i, j, k = sorted(x)
        if n[i] < n[k] < n[j]:
            print(f'({n[i]}, {n[j]}, {n[k]})')
            return

    # No solution is found
    print('()')

if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
