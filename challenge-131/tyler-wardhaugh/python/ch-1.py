#!/usr/bin/env python3
"""Challenge 131, Task 1"""

import sys


DEFAULT_INPUT = [[1, 2, 3, 6, 7, 8, 9]]


def consecutive_arrays(coll: list[int]) -> list[list[int]]:
    if not coll:
        return [[]]

    results = []
    prev = coll[0]
    for v in coll:
        if prev + 1 != v:
            results.append([])
        results[-1].append(v)
        prev = v
        
    return results


def main(args: list[str] = None) -> None:
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    coll = None
    if args:
        import json
        coll = json.loads(args[0])
    else:
        coll = DEFAULT_INPUT[0]

    results = consecutive_arrays(coll)
    print(f'({str(results)[1:-1]})')


if __name__ == '__main__':
    sys.exit(main())
