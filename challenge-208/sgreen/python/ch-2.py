#!/usr/bin/env python3

import sys


def main(array):
    missing = None
    duplicate = None

    for i in range(1, len(array)+1):
        # Find out how many times this number appears in the list
        count = sum(1 for n in array if n == i)
        if count == 0:
            missing = i
        elif count > 1:
            duplicate = i

    if missing is None:
        print(-1)
    else:
        print(f'({duplicate or ""}, {missing})')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
