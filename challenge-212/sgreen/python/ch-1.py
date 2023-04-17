#!/usr/bin/env python3

import sys
import string


def main(array):
    original_word = array.pop(0)
    lower_alphabet = list(string.ascii_lowercase)
    upper_alphabet = list(string.ascii_uppercase)
    new_word = ''

    for i, original_letter in enumerate(original_word):
        # Which alphabet?
        alphabet = lower_alphabet if original_letter in lower_alphabet else upper_alphabet

        # Calculate position of new letter
        pos = (alphabet.index(original_letter) + int(array[i])) % 26

        # ... and add it to the string
        new_word += alphabet[pos]

    print(new_word)


if __name__ == '__main__':
    main(sys.argv[1:])
