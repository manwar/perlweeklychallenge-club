#!/usr/bin/env python3

import sys


def main(words, acronym):
    # Calculate the first letters from the words
    first_letters = ''.join(map(lambda w: w[0], words))
    print('true' if first_letters.lower() == acronym.lower() else 'false')


if __name__ == '__main__':
    # The last value is the 'acronym'
    acronym = sys.argv.pop()
    main(sys.argv[1:], acronym)
