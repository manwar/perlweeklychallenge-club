#!/usr/bin/env python3

import re
import sys


def minimum_common(list1: list[int], list2: list[int]) -> int:
    intersection = set(list1) & set(list2)
    return min(intersection) if intersection else -1


def main():
    # Convert input into integers
    list1 = map(int, re.split(r'\D+', sys.argv[1]))
    list2 = map(int, re.split(r'\D+', sys.argv[2]))
    result = minimum_common(list1, list2)
    print(result)


if __name__ == '__main__':
    main()
