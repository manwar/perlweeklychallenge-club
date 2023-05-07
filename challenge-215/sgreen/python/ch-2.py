#!/usr/bin/env python

import sys


def main(array):
    to_place = array.pop()

    for i in range(1, len(array)-1):
        # Are the number before the current one, the current one and the next one all zero?
        if array[i-1] == 0 and array[i] == 0 and array[i+1] == 0:
            # If so, we can put a one here
            array[i] = 1
            to_place -= 1
            if to_place == 0:
                # We have placed all the ones
                print(1)
                return

    # There is no possible solution
    print(0)


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
