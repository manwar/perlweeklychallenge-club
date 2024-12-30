#!/usr/bin/env python3

import sys
from functools import cmp_to_key


def number_sort(i1: int, i2: int) -> int:
    # Return -1 if the first number is smaller, 1 if the second number is
    #  or 0 if they are the same

    # Convert the integers to strings
    s1 = str(i1)
    s2 = str(i2)

    # Combine them
    c1 = int(s1 + s2)
    c2 = int(s2 + s1)

    if c1 < c2:
        return -1
    if c1 > c2:
        return 1

    # They are the same!
    return 0


def largest_number(ints: list) -> int:
    sorted_ints = sorted(ints, key=cmp_to_key(number_sort), reverse=True)
    return int(''.join(map(str, sorted_ints)))


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = largest_number(array)
    print(result)


if __name__ == '__main__':
    main()
