#!/usr/bin/env python3

import sys


def main(n):
    # Find numbers between 0 and the length of n that don't appear in the input
    missing = [i for i in range(len(n)+1) if i not in n]
    print(*missing, sep=', ')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
