#!/usr/bin/env python

import sys


def main(inputs):
    i = int(inputs[0])
    j = int(inputs[1])
    k = int(inputs[2])
    numbers = []

    # Ensure we don't do something stupid
    if (k > i * j):
        raise Exception('Not enough elements')

    for m in range(1, i+1):
        for n in range(1, j+1):
            numbers.append(m*n)

    numbers.sort()
    print(numbers[k - 1])


if __name__ == '__main__':
    main(sys.argv[1:])
