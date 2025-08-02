#!/usr/bin/env python3

import sys


def min_diff(ints: list) -> int:
    # Sort the integers
    sorted_ints = sorted(ints)

    # Start by looking at the difference between the first two integers
    min_diff = sorted_ints[1] - sorted_ints[0]

    # Check if there is a better match
    for idx in range(2, len(ints)):
        if sorted_ints[idx] - sorted_ints[idx-1] < min_diff:
            # There is, updated min_diff
            min_diff = sorted_ints[idx] - sorted_ints[idx-1]

    return min_diff


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = min_diff(array)
    print(result)


if __name__ == '__main__':
    main()
