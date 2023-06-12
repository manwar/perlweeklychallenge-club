#!/usr/bin/env python

import math
import sys
from itertools import permutations


def main(ints):
    solution = []
    for p in permutations(ints):
        # Have we seen this solution before
        if p in solution:
            continue

        # Is each pair a square of an integer
        for i in range(1, len(ints)):
            sqrt = math.sqrt(p[i-1] + p[i])
            if sqrt != int(sqrt):
                break
        else:
            # It is. Add it the solution if we haven't seen it before
            solution.append(p)

    print(*solution, sep=', ')


if __name__ == '__main__':
    array = [int(n) for n in sys.argv[1:]]
    main(array)
