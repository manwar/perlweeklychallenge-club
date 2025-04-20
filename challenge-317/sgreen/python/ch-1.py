#!/usr/bin/env python3

import sys


def is_acronyms(array: list, word: str) -> bool:
    # Make up the acronym for the first letter in each word
    acronym = ''.join(s[0] for s in array)

    # Compare it to the supplied string
    return acronym.lower() == word.lower()


def main():
    # The last string is the word (acronym)
    result = is_acronyms(sys.argv[1:-1], sys.argv[-1])
    print(result)


if __name__ == '__main__':
    main()
