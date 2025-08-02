#!/usr/bin/env python3

import sys


def decode_xor(encoded: list, initial: int) -> list:
    # Start with the initial value
    orig = [initial]

    for i in encoded:
        # Add this value XORed with the last value in the list
        orig.append(i ^ orig[-1])

    return orig


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    initial = array.pop()
    result = decode_xor(array, initial)
    print(result)


if __name__ == '__main__':
    main()
