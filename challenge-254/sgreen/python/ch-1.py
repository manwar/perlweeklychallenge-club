#!/usr/bin/env python3

import sys


def three_power(n: int) -> bool:
    # Get the closest integer to a cube root
    i = round(abs(n) ** (1/3))

    # Return true if this number is indeed a cube root
    return i ** 3 == abs(n)


def main():
    # Convert input into integers
    n = int(sys.argv[1])
    result = three_power(n)
    print('true' if result else 'false')


if __name__ == '__main__':
    # Convert input into integers
    main()
