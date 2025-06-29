#!/usr/bin/env python3

import sys


def mad(ints: list) -> list[list[int]]:
    """Find pairs of integers with the minimum absolute difference.

    Args:
        ints (list): List of integers.

    Returns:
        list[list[int]]: List of pairs of integers with the minimum absolute difference.
    """

    ints = sorted(ints)
    min_diff = None
    min_diff_pairs = []
    for i in range(len(ints) - 1):
        diff = ints[i + 1] - ints[i]
        if min_diff is None or diff < min_diff:
            min_diff = diff
            min_diff_pairs = []
        if diff == min_diff:
            min_diff_pairs.append([ints[i], ints[i + 1]])

    return min_diff_pairs

def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = mad(array)
    print(result)


if __name__ == '__main__':
    main()
