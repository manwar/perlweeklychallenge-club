#!/usr/bin/env python3
"""Challenge 100, Task 2"""

import sys
from functools import reduce


DEFAULT_INPUT = [ [1], [2,4], [6,4,9], [5,1,7,2] ]


def min_row(row):
    """For a row of length n, generate n-1 numbers representing the pair of
    each element in row with its right neighbor."""
    for x, y in zip(row, row[1:]):
        yield min(x, y)


def min_triangle_sum(triangle):
    """Find the mininum path sum for the triangle from top to bottom."""
    def f(acc, row):
        return [x + y for x, y in zip(min_row(acc), row)]
    ans = reduce(f, reversed(triangle))    
    return ans[0]


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    triangle = None
    if args:
        import json
        triangle = json.loads(args[0])
    else:
        triangle = DEFAULT_INPUT

    print(min_triangle_sum(triangle))


if __name__ == '__main__':
    sys.exit(main())
