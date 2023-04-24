#!/usr/bin/env python

import sys


def main(array):
    # Sort the numbers, evens first
    array.sort(key=lambda x: (x % 2, x))
    print(*array, sep=', ')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
