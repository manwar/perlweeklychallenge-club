#!/usr/bin/env python3

import sys


def min_gap(ints: list) -> int:
    # Start by looking at the difference between the first two integers
    min_gap = ints[1] - ints[0]
    min_value = ints[1]

    # Check if there is a better match
    for idx in range(2, len(ints)):
        if ints[idx] - ints[idx-1] < min_gap:
            min_gap = ints[idx] - ints[idx-1]
            min_value = ints[idx]

    return min_value


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = min_gap(array)
    print(result)


if __name__ == '__main__':
    main()
