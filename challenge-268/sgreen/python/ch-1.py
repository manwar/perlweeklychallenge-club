#!/usr/bin/env python3

import sys


def magic_number(x: list, y: list) -> int | None:
    # Check we have equal length lists
    if len(x) != len(y):
        raise ValueError('Lists must be of the same length')

    # Sort the lists
    x = sorted(x)
    y = sorted(y)

    # Calculate the difference between the first values
    diff = y[0] - x[0]

    for i in range(len(x)):
        if y[i] - x[i] != diff:
            # There is no single magic number
            return None

    # Return the magic number
    return diff


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    half = len(array) // 2
    result = magic_number(array[:half], array[half:])
    if result:
        print(result)
    else:
        print('No magic number found!')


if __name__ == '__main__':
    main()
