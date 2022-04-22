#!/usr/bin/env python

import sys


def main(s):
    # Convert strings into integers
    n = [int(x) for x in s]

    idx = -1

    for i in range(1, len(n)):
        # If the sum of digits to the left match the sum of digits to the
        #  right, we have found a solution.
        if sum(n[0:i]) == sum(n[i+1:]):
            idx = i
            break

    print(idx)


if __name__ == '__main__':
    main(sys.argv[1:])
