#!/usr/bin/env python3

import sys


def main(n):
    solutions = []

    # Go through the list until it is exhausted
    while len(n):
        start = end = n.pop(0)

        # See if the next number is one more than the last value
        while len(n) > 0 and n[0] == end+1:
            end = n.pop(0)

        # We have found a range
        if start != end:
            solutions.append(f'[{start},{end}]')

    # Print solution
    if solutions:
        print(*solutions, sep=', ')
    else:
        print('No solutions found!')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
