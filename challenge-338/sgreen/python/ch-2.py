#!/usr/bin/env python3

import re
import sys


def max_distance(arr1: list[int], arr2: list[int]) -> int:
    """Return the highest distance between any two integers in the lists.

    Args:
        arr1: A list of integers.
        arr2: A list of integers.

    Returns:
        The highest distance between any two integers in the lists.
    """
    return max(abs(a - b) for a in arr1 for b in arr2)


def main():
    # Convert input into integers.
    arr1 = [int(n) for n in re.split(r'\D+', sys.argv[1])]
    arr2 = [int(n) for n in re.split(r'\D+', sys.argv[2])]
    result = max_distance(arr1, arr2)
    print(result)


if __name__ == '__main__':
    main()
