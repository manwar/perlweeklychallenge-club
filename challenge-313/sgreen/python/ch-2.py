#!/usr/bin/env python3

import sys


def reversed_letters(typed: str) -> str:
    # Extract letters from the string
    letters = [s for s in typed if s.isalpha()]

    # Loop through each character in the original string
    new_string = ''
    for char in typed:
        if char.isalpha():
            # If it is a letter, that the last letter from the letters list
            new_string += letters.pop()
        else:
            # Take the character from the string
            new_string += char

    return new_string


def main():
    result = reversed_letters(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
