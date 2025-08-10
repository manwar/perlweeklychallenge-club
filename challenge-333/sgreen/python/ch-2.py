#!/usr/bin/env python3

import sys


def duplicate_zeros(ints: list) -> list:
    solution = []
    for i in ints:
        if i == 0:
            # Duplicate the zero
            solution.append(0)
        solution.append(i)

    return solution[:len(ints)]


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = duplicate_zeros(array)
    print(result)


if __name__ == '__main__':
    main()
