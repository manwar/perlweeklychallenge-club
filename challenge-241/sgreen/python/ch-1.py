#!/usr/bin/env python3

import sys


def main(ints, diff):
    # Even though the task says the list is sorted, let's do it anyway
    ints = sorted(ints)
    count = 0

    for i in ints:
        # Check the the next two values are in the list
        if i+diff in ints and i+diff*2 in ints:
            count += 1

    print(count)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]

    # The last value is the diff
    diff = array.pop()
    main(array, diff)
