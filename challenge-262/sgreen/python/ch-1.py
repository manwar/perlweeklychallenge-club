#!/usr/bin/env python3

import sys


def max_type(ints: list) -> int:
    """Count the maximum number of positive or negative integers

    Args:
        ints (list): The list

    Returns:
        int: The maximum number
    """

    neg_count = pos_count = 0
    for i in ints:
        if i < 0:
            neg_count += 1
        elif i > 0:
            pos_count += 1

    return max(neg_count, pos_count)


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = max_type(array)
    print(result)


if __name__ == '__main__':
    main()
