#!/usr/bin/env python3
"""Challenge 101, Task 2"""

import sys


DEFAULT_INPUT = [[0, 1], [1, 0], [2, 2]]


def contains_origin(triangle):
    """Determine if the triangle formed by the given three points cover the (0,0)
    origin on a 2D plane, using the Barycentric Coordinate Sytem method from
    https://totologic.blogspot.com/2014/01/accurate-point-in-triangle-test.html"""
    (x1, y1), (x2, y2), (x3, y3) = triangle

    denominator = (y2 - y3) * (x1 - x3) + (x3 - x2) * (y1 - y3)
    A = ((y2 - y3) * (0 - x3) + (x3 - x2) * (0 - y3)) / denominator
    B = ((y3 - y1)*(0 - x3) + (x1 - x3)*(0 - y3)) / denominator
    C = 1 - A - B

    return all(0 <= x <= 1 for x in [A, B, C])


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

    result = 1 if contains_origin(triangle) else 0
    print(result)


if __name__ == '__main__':
    sys.exit(main())
