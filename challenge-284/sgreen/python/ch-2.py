#!/usr/bin/env python3

import json
import sys


def find_index(lst: list, val: int):
    # Find the position of val in lst. If it does not appear, return the
    #  length of the list
    return lst.index(val) if val in lst else len(lst)


def relative_sort(list1: list, list2: list) -> list:
    # Sort the first list, in the order they appear in the second list. If
    # it doesn't appear in the second list, append to the end in numerical order.
    return sorted(list1, key=lambda i: (find_index(list2, i), i))


def main():
    lists = json.loads(sys.argv[1])
    result = relative_sort(*lists)

    # Convert to a tuple to match expected output
    print(tuple(result))


if __name__ == '__main__':
    main()
