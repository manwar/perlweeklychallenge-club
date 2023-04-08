#!/usr/bin/env python3

from itertools import combinations
import sys


def main(n):
    # Calculate average
    avg = sum(n) / len(n)

    # A single element is always true
    if len(n) == 1:
        print('true')
        return

    # Consider combination of size 1 to half the length
    for i in range(1, len(n)//2+1):
        # Work through each combination
        for c in combinations(n, i):
            # If combination average is same, the remaining items also will be
            if sum(c) / i == avg:
                print('true')
                return

    print('false')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
