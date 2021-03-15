#!/usr/bin/env python3
"""Challenge 98, Task 2"""

import sys


DEFAULT_INPUT = ([1, 2, 3, 4], 3)


def binary_search(coll, n, start, end):
    """Return the index of n if it is present in coll. If it is not present,
    return -(insertion_point - 1)"""

    if end >= start:
        mid = start + (end - start) // 2
        v = coll[mid]

        if v == n:
            return mid
        elif v > n:
            return binary_search(coll, n, start, mid - 1)
        else:
            return binary_search(coll, n, mid + 1, end)
    else:
        return -1 * start - 1


def search_insert_position(coll, n):
    """Return the index of the given target n if found in the sorted integer
    array coll"""

    index = binary_search(coll, n, 0, len(coll) - 1)
    if index < 0:
        index = -1 * index - 1
    return index


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    ns, n = args[0:1] if args else DEFAULT_INPUT
    print(search_insert_position(ns, n))


if __name__ == '__main__':
    sys.exit(main())
