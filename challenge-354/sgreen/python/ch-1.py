#!/usr/bin/env python3

import sys


def min_abs_diff(ints: list) -> list:
    """Find all pairs of integers with the smallest absolute difference.

    Args:
        ints (list): A list of integers.

    Returns:
        list: A list of lists, each containing a pair of integers with the smallest absolute difference.
    """
    ints = sorted(ints)
    min_abs_diff = None
    result = []

    for i in range(len(ints) - 1):
        abs_diff = ints[i + 1] - ints[i]
        if min_abs_diff is None or abs_diff < min_abs_diff:
            min_abs_diff = abs_diff
            result = [[ints[i], ints[i + 1]]]
        elif abs_diff == min_abs_diff:
            result.append([ints[i], ints[i + 1]])

    return result


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = min_abs_diff(array)
    print(result)


if __name__ == "__main__":
    main()
