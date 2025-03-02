#!/usr/bin/env python3

import json
import sys


def array_intersection(sets: list[list[int]]) -> list:
    # Take the first set to seed the data
    solution = set(sets.pop(0))

    for s in sets:
        # Take the intersection of the remaining lists
        solution &= set(s)

    # Convert the set into a sorted list
    return sorted(solution)

def main():
    # Convert input into a list of list of integers
    matrix = json.loads(sys.argv[1])
    result = array_intersection(matrix)
    print(result)


if __name__ == '__main__':
    main()
