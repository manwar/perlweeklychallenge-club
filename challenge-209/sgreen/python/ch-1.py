#!/usr/bin/env python3

import sys


def main(array):
    # Is the last thing we found an 'a'
    last_a = False

    while len(array):
        # Retrieve the first character found
        char = array.pop(0)
        if char == '0':
            # We found an 'a'
            last_a = True
        elif char == '1':
            # If it is 1, then we also want to remove the next character
            last_a = False
            array.pop(0)
        else:
            raise ValueError(f"Unexpected value '{char}'")

    # Was the last character an 'a'?
    print('1' if last_a else '0')


if __name__ == '__main__':
    main(sys.argv[1:])
