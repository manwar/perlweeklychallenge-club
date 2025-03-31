#!/usr/bin/env python3

import sys


def sort_column(strs: list) -> int:
    """Count the number of columns that are not sorted lexicographically

    Args:
        strs (list): A list of strings

    Raises:
        ValueError: If the strings are not of the same length

    Returns:
        int: The number of columns that are NOT sorted lexicographically
    """

    # Check all strings are of the same length
    if any(len(s) != len(strs[0]) for s in strs):
        raise ValueError('Strings are not of the same length')

    unsorted_count = 0

    for idx in range(len(strs[0])):
        # Check that the characters at position idx are sorted
        characters = [s[idx] for s in strs]
        if characters != sorted(characters):
            unsorted_count += 1

    # Return the counted of unsorted columns
    return unsorted_count


def main():
    result = sort_column(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
