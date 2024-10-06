#!/usr/bin/env python3

import sys


def third_maximum(ints: list) -> str:
    # Sort the list, removing duplicates
    sorted_ints = sorted(set(ints))

    if len(sorted_ints) < 3:
        # If there are less than 3 elements, return the largest
        return sorted_ints[-1]
    else:
        # Otherwise, return the third largest
        return sorted_ints[-3]


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = third_maximum(array)
    print(result)


if __name__ == '__main__':
    main()
