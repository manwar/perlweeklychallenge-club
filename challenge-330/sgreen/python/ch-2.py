#!/usr/bin/env python3

import sys


def title_capital(input_string: str) -> str:
    """
    Convert the input string to title case, capitalizing the first letter of
    each word longer than 2 characters, and converting the rest to lowercase.

    :param input_string: The string to convert to title case.
    :return: The modified string in title case.
    """
    # Convert the input string to lowercase, split it into words
    words = input_string.lower().split()

    # Capitalize the first letter of each word longer than 2 characters
    new_words = [
        word.capitalize() if len(word) > 2 else word
        for word in words
    ]

    # Join the words back into a single string with spaces
    return ' '.join(new_words)


def main():
    result = title_capital(sys.argv[1])
    print('"' + result+'"')


if __name__ == '__main__':
    main()
