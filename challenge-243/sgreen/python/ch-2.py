#!/usr/bin/env python3

import math
import sys


def main(ints):
    solution = sum(math.floor(i / j) for i in ints for j in ints)
    print(solution)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
