#!/usr/bin/env python3

import string
import sys


def encrypted_string(input_string: str, i: int) -> str:
    # Make sure i is in the range 0 - 25.
    i = i % 26

    if i == 0:
        # Short cut if there is no transformation required
        return input_string

    # Create mapping of old and new letters
    old_letters = string.ascii_lowercase
    new_letters = old_letters[i:] + old_letters[:i]
    old_letters += old_letters.upper()
    new_letters += new_letters.upper()
    mapping = dict(zip(old_letters, new_letters))

    # Return the "encrypted" string
    return "".join(mapping.get(char, char) for char in input_string)


def main():
    result = encrypted_string(sys.argv[1], int(sys.argv[2]))
    print(result)


if __name__ == "__main__":
    main()
