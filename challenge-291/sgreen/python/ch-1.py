#!/usr/bin/env python3

import sys


def middle_index(ints: list) -> int:
    for i in range(len(ints)):
        # See if the sum of the integers to the left of this position is the
        #  same as the remaining sum
        if sum(ints[:i]) == sum(ints[i + 1:]):
            # It is, so return this position
            return i

    # No match found
    return -1


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = middle_index(array)
    print(result)


if __name__ == '__main__':
    main()
