#!/usr/bin/env python

import sys


def main(fibs):
    # Sanity check
    if len(fibs) != 2:
        raise ValueError('You must specify two inputs')
    if len(fibs[0]) != len(fibs[1]):
        raise ValueError('Strings must be of the same length')

    # Keep compounding the strings until we have at least 51 digits
    while len(fibs) == 2 or len(fibs[-1]) < 51:
        fibs.append(fibs[-2] + fibs[-1])

    # Print the 51st character from the last string
    print(fibs[-1][50])


if __name__ == '__main__':
    main(sys.argv[1:])
