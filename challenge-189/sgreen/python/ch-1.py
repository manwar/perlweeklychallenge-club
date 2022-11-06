#!/usr/bin/env python3

import sys

def main(array):
    # The last value is the target
    target = array.pop()

    # Find items greater than the target
    array = sorted([ x for x in array if x > target ])

    # Print the first value if there is one.
    if len(array):
        print(array[0])
    else:
        # else print the target
        print(target)

if __name__ == '__main__':
    main(sys.argv[1:])