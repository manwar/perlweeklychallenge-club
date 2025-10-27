#!/usr/bin/env python3

from collections import Counter
from itertools import chain, permutations
import json
import sys


def array_formation(source: list[list[int]], target: list[int]) -> bool:
    """Determine if the target array can be formed by concatenating the source arrays in any order.

    Args:
        source: A list of lists of integers.
        target: A list of integers.

    Returns:
        True if the target can be formed, False otherwise.
    """

    # Check that a solution is possible
    if Counter(chain.from_iterable(source)) != Counter(target):
        return False

    # Generate all possible arrangements of the source lists
    for perm in permutations(source):
        combined = list(chain.from_iterable(perm))
        if combined == target:
            # It matches the target
            return True

    # No arrangement will match the target
    return False


def main():
    # Convert the first argument into a list of lists of integers
    source = json.loads(sys.argv[1])

    # Convert the remaining arguments into integers
    target = [int(n) for n in sys.argv[2:]]
    result = array_formation(source, target)
    print(result)


if __name__ == '__main__':
    main()
