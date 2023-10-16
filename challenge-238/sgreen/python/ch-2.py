#!/usr/bin/env python3

from math import prod
import sys


def main(ints):
    steps = {}
    for i in ints:
        # Calculate the steps required for each int to get a single digit
        steps[i] = 0
        num = abs(i)
        while len(str(num)) > 1:
            num = prod(map(int, str(num)))
            steps[i] += 1

    # Sort the integers in ascender order, and then by the steps required
    sorted_ints = sorted(ints)
    sorted_ints = sorted(sorted_ints, key=lambda i: steps[i])

    print('(' + ', '.join(map(str, sorted_ints)) + ')')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
