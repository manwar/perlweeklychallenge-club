#!/usr/bin/env python3

import sys


def main(n):
    # Sort the list numerical
    n = sorted(n)

    # Return the sum of the the odd positioned items (1st, 3rd, 5th, ...)
    print(sum(n[::2]))


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
