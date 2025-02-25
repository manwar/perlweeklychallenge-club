#!/usr/bin/env python3

import re
import sys


def word_break(s: str, words: list) -> bool:
    # Turn the words into a regular expression
    pattern = '^(' + '|'.join(map(re.escape, words)) + ')+$'

    # Check if the string matches the pattern
    return True if re.search(pattern, s) else False


def main():
    # The first value is the string, the rest are the words
    result = word_break(sys.argv[1], sys.argv[2:])
    print('true' if result else 'false')


if __name__ == '__main__':
    main()
