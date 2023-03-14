#!/usr/bin/env python3

import re
import sys


def main(words):
    # Define the regular expression that makes up a single line on a keyboard
    r = '^(?:[qwertyuiop]+|[asdfghjkl]+|[zxcvbnm]+)$'

    # Find all words that match the pattern, and print it
    matched_words = [w for w in words if re.search(r, w, re.IGNORECASE)]
    print('(' + ','.join(f'"{w}"' for w in matched_words) + ')')


if __name__ == '__main__':
    main(sys.argv[1:])
