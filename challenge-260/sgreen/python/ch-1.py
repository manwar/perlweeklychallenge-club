#!/usr/bin/env python3

from collections import defaultdict
import sys


def uniq_occurrences(ints: list) -> bool:
    """Check the frequency of integers are unique

    Args:
        ints (list): The integers

    Returns:
        bool: Whether the frequency of the list is unique
    """

    # Calculate the frequency of each integer
    freq = defaultdict(int)
    for i in ints:
        freq[i] += 1

    # Return if we have seen a frequency already
    seen = {}
    for i in freq.values():
        if i in seen:
            return False
        seen[i] = 1

    # We have a unique orrurrence list
    return True


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = uniq_occurrences(array)
    print('1' if result else '0')


if __name__ == '__main__':
    main()
