#!/usr/bin/env python3
"""Challenge 99, Task 1"""

import sys
from fnmatch import fnmatch


DEFAULT_INPUT = ('abcde', 'a*e')


def pattern_match(string, pattern):
    """Return true if pattern p matches string s, according to glob rules."""
    return fnmatch(string, pattern)


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    s, p = args[0:1] if args else DEFAULT_INPUT
    if pattern_match(s, p):
        print(1)
    else:
        print(0)


if __name__ == '__main__':
    sys.exit(main())
