#!/usr/bin/env python3

import sys


def main(sentences):
    # Count the number of spaces + 1
    words = [x.count(' ')+1 for x in sentences]

    # Display the maximum number of words
    print(max(words))


if __name__ == '__main__':
    main(sys.argv[1:])
