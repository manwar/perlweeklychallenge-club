#!/usr/bin/env python

import math
import sys


def main(inputs):
    m = int(inputs[0])
    n = int(inputs[1])

    if m < 1:
        raise ValueError('The first number must be a positive integer')
    if n < 1:
        raise ValueError('The second number must be a positive integer')

    # We know the first three values in the sequence are the two numbers and
    # the sum
    seq = [m, n, m + n]
    current_value = seq[-1] + 1

    while len(seq) < 10:
        sums = 0
        for i in range(m, math.ceil(current_value / 2)):
            j = current_value - i
            if i in seq and j in seq:
                sums += 1

        if sums == 1:
            seq.append(current_value)

        current_value += 1

    print(*seq, sep=', ')


if __name__ == '__main__':
    main(sys.argv[1:])
