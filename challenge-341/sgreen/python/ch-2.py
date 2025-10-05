#!/usr/bin/env python3

import sys


def reverse_prefix(input_string: str, char: str) -> str:
    """
    Reverse the prefix of input_string up to and including the first occurrence of char.

    Args:
        input_string (str): The input string.
        char (str): The character to find in the input string.

    Returns:
        str: The modified string with the prefix reversed.
    """

    # Find the position of the first occurrence of char in input_string
    pos = input_string.find(char)

    # If char is not found, raise an error
    if pos == -1:
        raise ValueError(f"Character '{char}' not found in input string.")

    # Reverse the first part of the string
    return input_string[pos::-1] + input_string[pos+1:]


def main():
    result = reverse_prefix(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == "__main__":
    main()
