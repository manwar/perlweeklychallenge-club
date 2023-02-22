#!/usr/bin/env python3

import sys


def main(n):
    # Sort the list numerical, removing duplicates
    n = sorted(set(n))

    if len(n) >= 3:
        # There are three or more integers, print the third largest
        print(n[-3])
    else:
        # There are less than three integers, print the largest
        print(n[-1])


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
