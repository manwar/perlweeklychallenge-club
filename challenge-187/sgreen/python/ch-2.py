#!/usr/bin/env python3

import sys
from decimal import Decimal
from itertools import combinations


def main(array):
    solution = None

    # Turn the array into integers
    n = [Decimal(x) for x in array]

    # Calculate for all combinations
    for new in combinations(n, 3):
        (a, b, c) = new
        if a + b > c and b + c > a and a + c > b:
            if solution is None or sum(new) > sum(solution):
                solution = sorted(new, reverse = True)

    if solution:
        print('(' + ', '.join(str(x) for x in solution) + ')')
    else:
        print('()')


if __name__ == '__main__':
    main(sys.argv[1:])
