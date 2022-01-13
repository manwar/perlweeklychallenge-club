#!/usr/bin/env python

import math
import sys


def main(n):
    # Convert '$n' into an integer
    n = int(n)
    ab = []

    # Find all possible values of ab (or cd)
    for i in range(1, int(math.sqrt(n)) + 1):
        if n % i == 0:
            # We found one
            this_ab = i + n / i

            # Check if it is one less/more than any other values
            if any(abs(this_ab - x) == 1 for x in ab):
                print("1")
                return

            # Add this value to be checked later
            ab.append(this_ab)

    print("0")


if __name__ == '__main__':
    main(sys.argv[1])
