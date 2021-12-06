#!/usr/bin/env python

import itertools
import sys


def main(inputs):
    m = int(inputs[0])
    n = int(inputs[1])
    comb = []

    # Get all combinations
    for r in range(1, len(str(m))):
        comb += list(int(''.join(x))
                     for x in itertools.combinations(str(m), r))

    # Find the number of elements that are divided by n with no remainder
    print(sum(x % n == 0 for x in comb))


if __name__ == '__main__':
    main(sys.argv[1:])
