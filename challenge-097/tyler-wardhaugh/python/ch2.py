#!/usr/bin/env python3
"""Challenge 97, Task 2"""

import sys
from collections import Counter

DEFAULT_INPUT = ('101100101', 3)


def _minflips(part):
    cnt = Counter({'0': 0, '1': 0})
    cnt.update(part)
    return min(*cnt.values())


def binary_substrings(bstr, size):
    numparts = len(bstr) // size
    return sum(_minflips(bstr[i::size]) for i in range(numparts))


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    if args:
        b, s = args[0:1]
    else:
        b, s = DEFAULT_INPUT

    print(binary_substrings(b, s))


if __name__ == '__main__':
    sys.exit(main())
