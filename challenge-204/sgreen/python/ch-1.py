#!/usr/bin/env python3

import sys


def main(n):

    # If the last value is less than the first, reverse it
    if n[0] > n[-1]:
        n = n[::-1]

    # Go through the positions 0 .. len(n)-2
    for i in range(len(n)-1):
        if n[i] > n[i+1]:
            # If the earlier value is higher, we don't have a solution
            print(0)
            return

    # We have a solution
    print('1')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
