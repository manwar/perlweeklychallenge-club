#!/usr/bin/env python3

import sys


def semi_ordered_permutation(ints: list) -> int:
    # Find the position of the first minimum and last maximum
    last_index = len(ints) - 1
    min_index = ints.index(min(ints))
    max_index = last_index - ints[::-1].index(max(ints))

    # If the maximum is before the minimum remove one
    offset = 1 if  max_index < min_index else 0
    return min_index + last_index - max_index - offset

def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = semi_ordered_permutation(array)
    print(result)


if __name__ == '__main__':
    main()
