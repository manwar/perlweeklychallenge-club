#!/usr/bin/env python3
"""Challenge 101, Task 1"""

import sys


DEFAULT_INPUT = [1, 2, 3, 4]


def print_matrix(mat, colsep=' '):
    """Pretty print a matrix (list of lists)"""
    strs = [[str(x) for x in row] for row in mat]
    lens = [max(len(x) for x in col) for col in zip(*strs)]
    fmt = colsep.join(f'{{:{x}}}' for x in lens)
    tbl = (fmt.format(*row) for row in strs)

    for row in tbl:
        print(row)


def get_min_size(coll_len):
    """Determine the minimum shape necessary for a matrix to hold len items."""
    f = lambda x: abs(x - coll_len // x)
    candidates = {x: f(x) for x in range(1, 1+coll_len) if coll_len % x == 0}

    rows = min(candidates, key=candidates.get)
    cols = coll_len // rows
    return rows, cols


def rotate_matrix(mat):
    """Rotate the matrix counterclockwise"""
    rotated_mat = [list(x) for x in zip(*mat)]
    rotated_mat.reverse()
    return rotated_mat



def _pack(coll, m, n):
    """Recursively pack an incoming coll into an m x n spiral matrix. This is a
    helper function for pack_spiral, not meant to be called directly."""
    if m == 1:
        yield [coll]
    elif n == 1:
        yield from ([x] for x in reversed(coll))
    else:
        result = rotate_matrix(list(_pack(coll[n:], n, m-1))) + [coll[:n]]
        yield from result


def pack_spiral(coll):
    """Return coll as a packed spiral matrix."""
    m, n = get_min_size(len(coll))
    spiral = list(_pack(coll, m, n))
    return spiral


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    coll = None
    if args:
        import json
        coll = json.loads(args[0])
    else:
        coll = DEFAULT_INPUT

    print_matrix(pack_spiral(coll))


if __name__ == '__main__':
    sys.exit(main())
