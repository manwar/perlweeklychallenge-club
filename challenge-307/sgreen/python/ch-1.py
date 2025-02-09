#!/usr/bin/env python3

import sys


def check_order(ints: list) -> str:
    # Sort the lists numerically
    sorted_ints = sorted(ints)
    differences = []

    for idx in range(len(ints)):
        if ints[idx] != sorted_ints[idx]:
            # If the value in the original list and sorted list at this
            #  position is different, add it to the differences list.
            differences.append(idx)

    # Return the list
    return differences


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = check_order(array)
    print(result)


if __name__ == '__main__':
    main()
