#!/usr/bin/env python3

from functools import reduce
from operator import mul
import math
import sys


def main(s):
    # Convert strings to integers, and get count of items
    n = [int(x) for x in s]
    c = len(n)

    # Calculate the different means
    am = sum(n) / c
    gm = reduce(mul, n, 1) ** (1 / c)
    hm = c / reduce(lambda x, y: x + (1/y if y != 0 else 0), list([0] + n))

    # Display results
    print(f"AM = { round(am, 1) }, GM = { round(gm, 1) }, HM = { round(hm, 1) }")


if __name__ == '__main__':
    main(sys.argv[1:])
