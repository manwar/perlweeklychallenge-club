#!/usr/bin/env python3

import sys


def main(x, y):
    # Convert the input into integers
    x = int(x)
    y = int(y)

    count = 0

    while x != 0 or y != 0:
        count += 1

        # Take the smaller number from the bigger number
        if x > y:
            x -= y
        elif y > x:
            y -= x
        else:
            # or if they are the same, off each other
            x = y = 0

    print(count)


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
