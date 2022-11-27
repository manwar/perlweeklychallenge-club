#!/usr/bin/env python

import sys


def main(n):
    '''Main function'''

    # Find the first power of two greater than n
    p = 1
    while p <= n:
        p *= 2

     # Print the inverse of n
    print(p-n-1)


if __name__ == '__main__':
    main(int(sys.argv[1]))
