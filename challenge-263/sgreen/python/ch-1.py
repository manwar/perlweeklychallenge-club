#!/usr/bin/env python3

import sys


def target_index(ints: list, k: int) -> list:
    # Sort the array
    ints = sorted(ints)

    # Return the indexes where the item is 'k'
    return [pos for pos, value in enumerate(ints) if value == k]


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    k = array.pop()
    result = target_index(array, k)
    print('(' + ', '.join(map(str, result)) + ')')


if __name__ == '__main__':
    main()
