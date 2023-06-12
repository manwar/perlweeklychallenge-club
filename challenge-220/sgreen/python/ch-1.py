#!/usr/bin/env python

import string
import sys


def main(words):
    # Turns the words into a set list, and take off the first word
    set_list = [set(w.lower()) for w in words]
    first_word = set_list.pop(0)
    letters = []

    # Go through each letter in the first word
    for letter in sorted(first_word):
        # And checks it is used in all other words
        if 'a' < letter < 'z' and all(letter in x for x in set_list):
            # It is! Add it to the letters list
            letters.append(letter)

    print(*letters, sep=', ')


if __name__ == '__main__':
    main(sys.argv[1:])
