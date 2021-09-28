#!/usr/bin/env python3
"""Challenge 131, Task 2"""

import sys


DEFAULT_INPUT = ['""[]()', '"I like (parens) and the Apple ][+" they said.']


def find_pairs(delimiters: str, search_string: str) -> tuple[str, str]:
    starters = {v for i, v in enumerate(delimiters) if i % 2 == 0}
    closers = {v for i, v in enumerate(delimiters) if i % 2 == 1}

    rstarters = []
    rclosers = []
    for v in search_string:
        if v in starters:
            rstarters.append(v)
        if v in closers:
            rclosers.append(v)

    return ''.join(rstarters), ''.join(rclosers)



def main(args: list[str] = None) -> None:
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    delimiters = None
    search_string = None
    if args:
        delimiters, search_string = args
    else:
        delimiters, search_string = DEFAULT_INPUT

    results = find_pairs(delimiters, search_string)
    print(*results, sep="\n")

if __name__ == '__main__':
    sys.exit(main())
