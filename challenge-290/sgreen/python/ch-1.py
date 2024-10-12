#!/usr/bin/env python3

import sys


def double_exists(ints: list) -> bool:

    # Iterate through list
    for i in ints:
        # If a value twice this value exists
        if i * 2 in ints:
            # ... and it is not zero, or zero appears at least twice
            if i != 0 or ints.count(0) > 1:
                return True

    # No values twice another value exists
    return False


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = double_exists(array)
    print('true' if result else 'false')


if __name__ == '__main__':
    main()
