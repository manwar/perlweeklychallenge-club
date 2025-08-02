#!/usr/bin/env python3

from collections import Counter
import sys


def appearance_33(ints: list) -> int | None:
    """Find the lowest value that appears at least 33% of the time

    Args:
        ints (list): A list of integers

    Returns:
        int|None: The lowest value, or None if there are none
    """
    # Calculate frequency of the integers
    freq = Counter(ints)

    # Calculate 33% of the number of items
    percent_33 = 0.33 * len(ints)

    # Return the minimum value that appears more than 33% of the time
    for i in sorted(freq):
        if freq[i] >= percent_33:
            return i

    return None


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = appearance_33(array)
    print(result)


if __name__ == '__main__':
    main()
