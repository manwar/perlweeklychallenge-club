#!/usr/bin/env python3

import sys


def consecutive_ones(ints: list) -> int:
    """
    Function to find the maximum number of consecutive 1s in a binary array.
    :param ints: List of integers (0s and 1s)
    :return: Maximum count of consecutive 1s
    """
    max_count = 0
    current_count = 0

    for num in ints:
        if num == 1:
            current_count += 1
            if current_count > max_count:
                max_count = current_count
        else:
            current_count = 0

    return max_count


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = consecutive_ones(array)
    print(result)


if __name__ == '__main__':
    main()
