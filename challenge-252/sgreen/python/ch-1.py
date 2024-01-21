#!/usr/bin/env python3

import sys


def main(ints):
    solution = 0
    length = len(ints)

    for pos in range(length):
        if length % (pos+1) == 0:
            # This is a special number. Add its square to the solution
            solution += ints[pos] ** 2

    print(solution)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
