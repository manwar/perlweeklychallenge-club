#!/usr/bin/env python3

import sys


def main(ints):
    solutions = 0
    for i, value in enumerate(ints):
        # Find future values that are less than half the current value
        solutions += sum(1 for j in ints[i+1:] if value > 2 * j)

    print(solutions)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
