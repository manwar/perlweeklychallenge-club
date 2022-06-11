#!/usr/bin/env python

import math
import sys

def main(n):
    # Check we have an integer >= 0
    num = int(n)
    if num < 0:
        raise ValueError("You must specify a non-negative integer")

    # Get the sum of factorials of each digit
    s = sum(math.factorial(int(x)) for x in n)
    print('1' if s == num else 0)

if __name__ ==  '__main__':
    main(sys.argv[1])