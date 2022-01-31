#!/usr/bin/env python

import itertools
from math import sqrt
import sys


def main(n):
    v = 'ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210'
    c = n

    if n < 2 or n > 22:
        raise ValueError('n must be between 2 and 22')

    # Get all digits for this number
    v = v[-n:]

    while c > 0:
        for x in itertools.permutations(v, c):
            # If the first digit is zero, reset the permutations to have
            #  one less digit
            if x[0] == '0':
                c -= 1
                break

            # Turn the tuple into a string (s) and its integer version (i)
            s = ''.join(x)
            i = int(s, n)

            # Calculate the square root of the integer
            r = sqrt(i)
            if r == int(r):
                # If it is a perfect square, then print the number and exit
                print(f'{s} ({int(r)}² = {i})')
                return

    # This should never happen as '1' is valid solution for all bases
    print('No solution!')


if __name__ == '__main__':
    main(int(sys.argv[1]))
