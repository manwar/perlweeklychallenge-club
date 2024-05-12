#!/usr/bin/env python3

import sys


def numbers_game(ints: list) -> list:
    # Check we have an even number of items
    if len(ints) % 2 != 0:
        raise ValueError('Please provide an even number of items!')

    # Sort the list
    ints = sorted(ints)

    for i in range(0, len(ints), 2):
        # Switch the pairs of numbers around
        ints[i], ints[i+1], = ints[i+1], ints[i]

    return ints


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = numbers_game(array)
    print(tuple(result))


if __name__ == '__main__':
    main()
