#!/usr/bin/env python3

import sys

from itertools import combinations

def buddy_strings(source: str, target: str) -> bool:
    # Strings must be of the same length
    if len(source) != len(target):
        return False

    for i, j in combinations(range(len(source)), 2):
        # Swap characters at positions i and j in source
        swapped = list(source)
        swapped[i], swapped[j] = swapped[j], swapped[i]
        # Check if the swapped string matches the target
        if ''.join(swapped) == target:
            return True

    return False


def main():
    result = buddy_strings(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
