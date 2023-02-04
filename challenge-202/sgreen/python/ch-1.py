#!/usr/bin/env python3

import sys


def main(n):
    # Count the number of sequential odd numbers
    odds = 0

    for i in n:
        if i % 2 == 1:
            odds += 1
            if odds >= 3:
                # We have found three sequential odd numbers
                print('1')
                return
        else:
            # Restart the count
            odds = 0

    # There is no solution
    print('0')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
