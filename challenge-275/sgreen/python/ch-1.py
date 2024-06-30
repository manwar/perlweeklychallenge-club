#!/usr/bin/env python3

import sys


def broken_keys(s: str, keys: list) -> int:
    """
    Counts the number of words in a string that do not contain any of the specified keys.

    Args:
        s (str): The input string.
        keys (list): A list of keys to check for in the words.

    Returns:
        int: The count of words that do not contain any of the specified keys.
    """

    # Convert values to lowercase
    words = s.lower().split(' ')
    keys = [key.lower() for key in keys]

    # Initialize the counter
    count = 0

    # Loop through the word.
    for word in words:
        if not any(key in word for key in keys):
            count += 1

    return count


def main():
    # The first value is the string and the rest are the keys
    result = broken_keys(sys.argv[1], sys.argv[2:])
    print(result)


if __name__ == '__main__':
    main()
