#!/usr/bin/env python3
import sys


def main(ints):
    # Sort the list
    ints_sorted = sorted(ints)

    # Count the occurrences of the same value in the list
    count = sum(1 for x in range(len(ints)) if ints[x] == ints_sorted[x])

    print(count)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
