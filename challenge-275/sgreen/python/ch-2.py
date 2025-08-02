#!/usr/bin/env python3

import string
import sys


def replace_digits(s: str) -> str:
    """
    Replaces digits in a string with corresponding letters from the alphabet.

    Args:
        s (str): The input string.

    Returns:
        str: The modified string with digits replaced by letters.
    """

    current_letter = None
    solution = ''
    alphabet = string.ascii_lowercase

    for char in s:
        if char.isdigit():
            if current_letter is None:
                raise ValueError('The first number must follow a letter.')
            solution += alphabet[(alphabet.index(current_letter) +
                                  int(char)) % 26]
        else:
            solution += char
            current_letter = char

    return solution


def main():
    result = replace_digits(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
