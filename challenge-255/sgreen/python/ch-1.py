#!/usr/bin/env python3

import sys


def frequency_count(s: str) -> dict:
    """Counts the frequency of each letter

    Args:
        s (str): The string to use

    Returns:
        dict: Key is the letter, values is the number of occurrences.
    """
    freq = {}

    for c in s:
        freq[c] = freq.get(c, 0) + 1

    return freq


def odd_character(s: str, t: str) -> str:
    """Finds extra character in second string

    Args:
        s (str): The first string
        t(str): The second string

    Returns:
        str: The extra character
    """
    first_freq = frequency_count(s)
    second_freq = frequency_count(t)

    for c in second_freq:
        if second_freq[c] > first_freq.get(c, 0):
            # We have found the extra character
            return c

    return 'No extra characters!'


def main():
    result = odd_character(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
