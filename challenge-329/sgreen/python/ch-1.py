#!/usr/bin/env python3

import re
import sys


def counter_integers(input_string: str) -> list[int]:
    # Find all integers in string
    m = re.findall(r"\d+", input_string)

    # Convert to integers
    solution = []

    for i in map(int, m):
        # Add them if they don't already appear
        if i not in solution:
            solution.append(i)

    return solution


def main():
    result = counter_integers(sys.argv[1])
    print(', '.join(map(str, result)))


if __name__ == '__main__':
    main()
