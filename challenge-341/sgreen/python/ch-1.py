#!/usr/bin/env python3

import sys


def broken_keyboard(input_string: str, broken_keys: list[str]) -> int:
    """
    Count the number of words that can be completely typed on a broken keyboard.

    Args:
        input_string (str): The input string containing words separated by spaces.
        broken_keys (list[str]): A list of broken keys (characters).

    Returns:
        int: The number of words that can be fully typed without using any broken keys.
    """

    # Convert everything to lower case
    input_string = input_string.lower()
    broken_keys = [key.lower() for key in broken_keys]

    # Count words that DON'T contain any broken keys
    completed_words = 0
    for word in input_string.split():
        if not any(char in broken_keys for char in word):
            completed_words += 1

    return completed_words

def main():
    # The first argument is the input string, the rest are broken keys
    input_string = sys.argv[1]
    broken_keys = sys.argv[2:]
    result = broken_keyboard(input_string, broken_keys)
    print(result)


if __name__ == "__main__":
    main()
