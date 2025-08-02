#!/usr/bin/env python3

import sys


def odd_sum(ints: list) -> int:
    solution = 0

    l = len(ints)

    # The odd-length length of sub array
    for length in range(1, l+1, 2):
        # The starting position of this sub array
        for start in range(0, l-length+1):
            solution += sum(ints[start:start+length])

    return solution


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = odd_sum(array)
    print(result)


if __name__ == '__main__':
    main()
