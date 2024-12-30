#!/usr/bin/env python3

import sys


def hamming_distance(ints: list) -> int:
    solution = 0

    # Work through each combination
    for i in range(len(ints)-1):
        for j in range(i+1, len(ints)):
            # Calculate the xor, convert to binary, count the ones
            x = ints[i] ^ ints[j]
            solution += bin(x).count('1')

    return solution


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = hamming_distance(array)
    print(result)


if __name__ == '__main__':
    main()
