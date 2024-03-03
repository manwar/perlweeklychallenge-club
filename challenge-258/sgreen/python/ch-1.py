#!/usr/bin/env python3

import sys


def count_even_digits(ints: list) -> int:
    return sum(1 for i in ints if len(str(i)) % 2 == 0)


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = count_even_digits(array)
    print(result)


if __name__ == '__main__':
    main()
