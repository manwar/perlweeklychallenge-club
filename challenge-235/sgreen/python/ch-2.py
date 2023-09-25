#!/usr/bin/env python3

import sys


def main(ints):
    solution = []

    # Work through the list
    for i in ints:
        # Add the original number
        solution.append(i)
        if i == 0:
            # Add it twice if it is zero
            solution.append(i)

    # Truncate list, and print it
    solution = solution[:len(ints)]
    print(*solution, sep=', ')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
