#!/usr/bin/env python3

import sys


def split_strings(words, sep):
    # Join the words together by the separator
    combined = sep.join(words)

    # Split them by the separator excluding empty strings
    return [ w for w in combined.split(sep) if w != '']

def main(inputs):
    # The separator is the last character
    sep = inputs.pop()
    result = split_strings(inputs, sep)
    print('"' + '", "'.join(result) + '"')

if __name__ == '__main__':
    main(sys.argv[1:])