#!/usr/bin/env python3

import sys


def complete_day(hours: list) -> int:
    """
    Counts the number of pairs of hours in the given list that sum up to a multiple of 24.

    Args:
        hours (list): A list of integers representing the hours.

    Returns:
        int: The number of pairs of hours that sum up to a multiple of 24.
    """
    count = 0
    items = len(hours)

    for i in range(items-1):
        for j in range(i+1, items):
            if (hours[i] + hours[j]) % 24 == 0:
                count += 1

    return count


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = complete_day(array)
    print(result)


if __name__ == '__main__':
    main()
