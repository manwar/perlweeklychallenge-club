#!/usr/bin/env python3

import sys


def main(n):
    solution = []
    half = n // 2

    # If we have an odd number, add a zero
    if n % 2 == 1:
        solution = [0]

    for i in range(half):
        # Add a pair of numbers
        solution.insert(0, -i-1)
        solution.append(i+1)

    print(*solution, sep=', ')


if __name__ == '__main__':
    # Convert input into integers
    main(int(sys.argv[1]))
