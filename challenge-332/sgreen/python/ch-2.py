#!/usr/bin/env python3

import sys
from collections import Counter


def odd_letters(input_string: str) -> bool:
    """
    Check if all letters in the input string have an odd frequency.

    Args:
        input_string (str): The input string to check.
    Returns:
        bool: True if all letters have an odd frequency, False otherwise.
    """

    freq = Counter(input_string)
    return all(count % 2 == 1 for count in freq.values())


def main():
    result = odd_letters(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
